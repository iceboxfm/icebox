import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/widgets/sort_dialog.dart';
import 'package:provider/provider.dart';

class FreezerItemSortButton extends StatelessWidget {
  const FreezerItemSortButton({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final freezerItems = context.watch<FreezerItems>();

    return IconButton(
      icon: const Icon(Icons.sort),
      onPressed: () => showDialog(
        context: context,
        builder: (ctx) => SortDialog(freezerItems.sortBy),
      ).then((value) => freezerItems.sortingBy(value)),
    );
  }
}
