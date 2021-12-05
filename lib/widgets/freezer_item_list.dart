import 'package:flutter/material.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/widgets/delete_confirmation_dialog.dart';
import 'package:icebox/widgets/dismissable_background.dart';
import 'package:icebox/widgets/filter_input.dart';
import 'package:icebox/widgets/limiting_banner.dart';
import 'package:icebox/widgets/quantity_dialog.dart';
import 'package:icebox/widgets/time_remaining.dart';
import 'package:provider/provider.dart';

class FreezerItemList extends StatelessWidget {
  const FreezerItemList({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    // FIXME: can I just share the FreezerItems object from parent?
    final freezerItems = context.watch<FreezerItems>();
    final freezers = context.read<Freezers>();

    // FIXME: add some info when filter results in empty list

    return Column(
      children: [
        if (freezerItems.category != null)
          LimitingBanner(
            type: 'category',
            limiter: freezerItems.category!.label,
            onCleared: () => freezerItems.limitCategory(null),
          ),
        if (freezerItems.freezer != null)
          LimitingBanner(
            type: 'freezer',
            limiter: freezers.retrieve(freezerItems.freezer!).description,
            onCleared: () => freezerItems.limitFreezer(null),
          ),
        FilterInput(freezerItems),
        Expanded(
          child: freezerItems.isNotEmpty
              ? ListView.builder(
                  itemCount: freezerItems.count(),
                  itemBuilder: (ctx, idx) {
                    final freezerItem = freezerItems[idx] as FreezerItem;

                    // FIXME: pull out a widget
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
                                    Text(freezerItem.quantity),
                                    _itemLocation(freezers, freezerItem),
                                  ],
                                ),
                              ),
                              trailing:
                                  TimeRemaining(freezerItem.timeRemaining),
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
                                freezerItems.save(
                                    freezerItem.copyWith(quantity: value));
                              }
                            });
                          }),
                      confirmDismiss: (direction) => showDialog(
                        context: context,
                        builder: (ctx) =>
                            DeleteConfirmationDialog(freezerItem.description),
                      ),
                      onDismissed: (direction) {
                        freezerItems.delete(freezerItem.id!).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '"${freezerItem.description}" was deleted.'),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        });
                      },
                    );
                  },
                )
              : const Center(
                  child: Text('No freezer items.'),
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
