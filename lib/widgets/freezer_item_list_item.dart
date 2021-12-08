import 'package:flutter/material.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/widgets/delete_confirmation_dialog.dart';
import 'package:icebox/widgets/dismissable_background.dart';
import 'package:icebox/widgets/time_remaining.dart';

class FreezerItemListItem extends StatelessWidget {
  final FreezerItem freezerItem;
  final String freezerDescription;
  final Function onDelete;
  final Function onLongPress;

  const FreezerItemListItem({
    required this.freezerDescription,
    required this.freezerItem,
    required this.onDelete,
    required this.onLongPress,
  });

  @override
  Widget build(final BuildContext context) {
    return Dismissible(
      key: ValueKey(freezerItem.id),
      direction: DismissDirection.endToStart,
      background: DismissibleBackground(),
      child: GestureDetector(
        child: Card(
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 2, right: 2),
            onTap: () => Navigator.of(context)
                .pushNamed(FreezerItemScreen.routeName, arguments: freezerItem),
            leading: freezerItem.category.image,
            title: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(freezerItem.description),
                  Text(freezerItem.quantity),
                  _itemLocation(freezerItem),
                ],
              ),
            ),
            trailing: TimeRemaining(freezerItem.timeRemaining),
          ),
        ),
        onLongPress: () => onLongPress(freezerItem),
      ),
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (ctx) => DeleteConfirmationDialog(freezerItem.description),
      ),
      onDismissed: (direction) {
        onDelete(freezerItem);
      },
    );
  }

  Widget _itemLocation(final FreezerItem item) {
    final shelf = item.location != null && item.location!.isNotEmpty
        ? '- ${item.location}'
        : '';

    return Text(
      '$freezerDescription $shelf',
      style: const TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
