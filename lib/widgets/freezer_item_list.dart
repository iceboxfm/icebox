import 'package:flutter/material.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/widgets/dismissable_background.dart';
import 'package:icebox/widgets/quantity_dialog.dart';
import 'package:icebox/widgets/time_remaining.dart';
import 'package:provider/provider.dart';

class FreezerItemList extends StatelessWidget {
  final FreezerItems _freezerItems;

  const FreezerItemList(this._freezerItems);

  @override
  Widget build(final BuildContext context) {
    final freezers = context.read<Freezers>();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _freezerItems.count(),
            itemBuilder: (ctx, idx) {
              final freezerItem = _freezerItems[idx] as FreezerItem;

              return Dismissible(
                key: ValueKey(freezerItem.id),
                direction: DismissDirection.endToStart,
                background: DismissibleBackground(),
                child: GestureDetector(
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 2, right: 2),
                        onTap: () => Navigator.of(context).pushNamed(
                            FreezerItemScreen.routeName,
                            arguments: freezerItem),
                        leading: freezerItem.category.image,
                        title: Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(freezerItem.description),
                              _itemLocation(freezers, freezerItem),
                              Text(freezerItem.quantity),
                            ],
                          ),
                        ),
                        trailing: TimeRemaining(freezerItem.timeRemaining),
                      ),
                    ),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => QuantityDialog(
                          freezerItem.description,
                          freezerItem.quantity,
                        ),
                      ).then((value) {
                        if (value != null) {
                          _freezerItems.save(freezerItem.copyWith(quantity: value));
                        }
                      });
                    }),
                confirmDismiss: (direction) => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: Text(
                      'Do you want to permanently delete "${freezerItem.description}"?',
                    ),
                    actions: [
                      TextButton(
                        child: const Text('No'),
                        onPressed: () => Navigator.of(ctx).pop(false),
                      ),
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () => Navigator.of(ctx).pop(true),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  _freezerItems.delete(freezerItem.id!).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('"${freezerItem.description}" was deleted.'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _itemLocation(final Freezers freezers, final FreezerItem item) {
    final freezer = freezers.retrieve(item.freezerId!).description;
    final shelf = item.location != null && item.location!.isNotEmpty
        ? '- ${item.location}'
        : '';

    return Text(
      '$freezer $shelf',
      style: const TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
