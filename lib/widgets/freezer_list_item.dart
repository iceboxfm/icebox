import 'package:flutter/material.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/screens/freezer_screen.dart';
import 'package:icebox/widgets/dismissable_background.dart';

class FreezerListItem extends StatelessWidget {
  final Freezer freezer;
  final int itemCount;
  final Function onDelete;

  const FreezerListItem({
    required this.freezer,
    required this.itemCount,
    required this.onDelete,
  });

  @override
  Widget build(final BuildContext context) {
    return Dismissible(
      key: ValueKey(freezer.id),
      direction: DismissDirection.endToStart,
      background: DismissibleBackground(),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(freezer.description),
          leading: freezer.type.image!,
          subtitle: _freezerShelves(freezer.shelves.length),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _itemCountLabel(itemCount),
          ),
          contentPadding: const EdgeInsets.only(left: 2, right: 2),
          onTap: () => Navigator.of(context).pushNamed(
            FreezerScreen.routeName,
            arguments: freezer,
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          // FIXME: pull into widget?
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: Text(
              'Do you want to permanently delete "${freezer.description}"?',
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
        );
      },
      onDismissed: (direction) {
        if (itemCount == 0) {
          onDelete(freezer);
        } else {
          // FIXME:: warn that cant delete with items
        }
      },
    );
  }

  Text _freezerShelves(final int shelfCount) {
    if (shelfCount == 0) {
      return const Text('No shelves');
    } else if (shelfCount == 1) {
      return const Text('1 shelf');
    } else {
      return Text('$shelfCount shelves');
    }
  }

  Text _itemCountLabel(final int count) {
    if (count == 0) {
      return const Text('Empty');
    } else if (count == 1) {
      return const Text('1 item');
    } else {
      return Text('$count items');
    }
  }
}
