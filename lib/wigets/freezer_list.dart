import 'package:flutter/material.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_screen.dart';
import 'package:icebox/wigets/dismissable_background.dart';
import 'package:provider/provider.dart';

class FreezerList extends StatelessWidget {
  final Freezers _freezers;

  const FreezerList(this._freezers);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _freezers.count,
      itemBuilder: (ctx, index) {
        final freezer = _freezers[index] as Freezer;

        return Dismissible(
          key: ValueKey(freezer.id),
          direction: DismissDirection.endToStart,
          background: DismissibleBackground(),
          child: Card(
            elevation: 2,
            child: ListTile(
              title: Text(freezer.description),
              leading: freezer.type.image!,
              subtitle: Text(
                '${freezer.shelves.isEmpty ? 'No' : freezer.shelves.length} shelves',
              ),
              contentPadding: const EdgeInsets.only(left: 2, right: 2),
              onTap: () => Navigator.of(context)
                  .pushNamed(FreezerScreen.routeName, arguments: freezer),
            ),
          ),
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
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
            if (context.read<FreezerItems>().count(freezer.id!) == 0) {
              _freezers.delete(freezer.id!).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${freezer.description}" was deleted.'),
                    duration: const Duration(seconds: 3),
                  ),
                );
              });
            } else {
              // FIXME:: warn that cant delete with items
            }
          },
        );
      },
    );
  }
}
