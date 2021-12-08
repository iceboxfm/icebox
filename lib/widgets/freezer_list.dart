import 'package:flutter/material.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/widgets/freezer_list_item.dart';
import 'package:provider/provider.dart';

class FreezerList extends StatelessWidget {
  const FreezerList({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final freezers = context.watch<Freezers>();
    final freezerItems = context.read<FreezerItems>();

    return freezers.isNotEmpty
        ? ListView.builder(
            itemCount: freezers.count,
            itemBuilder: (ctx, index) {
              final freezer = freezers[index] as Freezer;

              return FreezerListItem(
                freezer: freezer,
                itemCount: freezerItems.items
                    .where((fi) => fi.freezerId == freezer.id)
                    .length,
                onDelete: (f) => _deleteFreezer(context, freezers, f),
              );
            },
          )
        : const Center(child: Text('You have no freezers.'));
  }

  void _deleteFreezer(
    final BuildContext context,
    final Freezers freezers,
    final Freezer freezer,
  ) {
    freezers.delete(freezer.id!).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Freezer "${freezer.description}" was deleted.'),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }
}
