import 'package:flutter/material.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/widgets/item_filter_dialog.dart';
import 'package:provider/provider.dart';

class FreezerFilterButton extends StatelessWidget {
  final bool enabled;

  const FreezerFilterButton({
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final freezers = context.read<Freezers>();
    final freezerItems = context.watch<FreezerItems>();
    final selected = freezerItems.items.map((e) => e.freezerId!).toSet();

    return IconButton(
      icon: const Icon(Icons.ac_unit_outlined),
      onPressed: enabled && selected.length > 1
          ? () => showDialog(
                context: context,
                builder: (ctx) => ItemFilterDialog(
                  _selectedFreezers(ctx, freezers, selected),
                ),
              ).then((value) => freezerItems.limitFreezer(value))
          : null,
    );
  }

  List<ListTile> _selectedFreezers(
    final BuildContext context,
    final Freezers freezers,
    final Set<int> freezerIds,
  ) {
    return freezers.freezers
        .where((f) => freezerIds.contains(f.id))
        .map((f) => ListTile(
              leading: f.type.image,
              title: Text(f.description),
              onTap: () => Navigator.pop(context, f.id),
            ))
        .toList();
  }
}
