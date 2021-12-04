import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/widgets/category_dialog.dart';
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
                builder: (ctx) => CategoryDialog(selected),
              ).then((value) => freezerItems.limitCategory(value))
          : null,
    );
  }
}
