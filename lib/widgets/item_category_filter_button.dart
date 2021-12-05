import 'package:flutter/material.dart';
import 'package:icebox/models/item_categories.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/widgets/item_filter_dialog.dart';
import 'package:provider/provider.dart';

class ItemCategoryFilterButton extends StatelessWidget {
  const ItemCategoryFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final freezerItems = context.watch<FreezerItems>();

    final selected = freezerItems.items.map((e) => e.category).toSet();
    final multiple = selected.length > 1;

    return IconButton(
      icon: const Icon(Icons.category),
      onPressed: multiple
          ? () => showDialog(
                context: context,
                builder: (ctx) => ItemFilterDialog(_categories(ctx, selected)),
              ).then((value) => freezerItems.limitCategory(value))
          : null,
    );
  }

  List<ListTile> _categories(
    final BuildContext context,
    final Set<ItemCategory> selected,
  ) {
    final list = [...selected];
    list.sort();

    return list
        .map((c) => ListTile(
              leading: c.image,
              title: Text(c.label),
              onTap: () => Navigator.pop(context, c),
            ))
        .toList();
  }
}
