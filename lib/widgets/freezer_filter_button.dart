import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/widgets/freezer_dialog.dart';
import 'package:provider/provider.dart';

class FreezerFilterButton extends StatelessWidget {
  const FreezerFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final freezerItems = context.watch<FreezerItems>();

    final selected = freezerItems.items.map((e) => e.freezerId!).toSet();
    final multiple = selected.length > 1;

    return IconButton(
      icon: const Icon(Icons.ac_unit_outlined),
      onPressed: multiple
          ? () => showDialog(
                context: context,
                builder: (ctx) => FreezerDialog(selected),
              ).then((value) => freezerItems.limitFreezer(value))
          : null,
    );
  }
}
