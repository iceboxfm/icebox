import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/widgets/app_drawer.dart';
import 'package:icebox/widgets/freezer_filter_button.dart';
import 'package:icebox/widgets/freezer_item_list.dart';
import 'package:icebox/widgets/freezer_item_sort_button.dart';
import 'package:icebox/widgets/item_category_filter_button.dart';
import 'package:provider/provider.dart';

class FreezerItemsScreen extends StatelessWidget {
  static const String routeName = '/freezer-items';

  const FreezerItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder(
      future: _load(context),
      builder: (ctx, snap) {
        final bool loaded = snap.connectionState == ConnectionState.done;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Freezer Items"),
            actions: [
              FreezerFilterButton(enabled: loaded),
              ItemCategoryFilterButton(enabled: loaded),
              FreezerItemSortButton(enabled: loaded),
            ],
          ),
          drawer: const AppDrawer(),
          body: loaded
              ? const FreezerItemList()
              : const Center(child: CircularProgressIndicator()),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: loaded
                ? () =>
                    Navigator.of(context).pushNamed(FreezerItemScreen.routeName)
                : null,
          ),
        );
      },
    );
  }

  // FIXME: can this be done on app start?
  Future<void> _load(final BuildContext context) async {
    await context.read<Freezers>().load();
    await context.read<FreezerItems>().load();
  }
}
