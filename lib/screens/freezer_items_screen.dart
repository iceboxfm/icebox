import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/widgets/app_drawer.dart';
import 'package:icebox/widgets/category_dialog.dart';
import 'package:icebox/widgets/freezer_dialog.dart';
import 'package:icebox/widgets/freezer_item_list.dart';
import 'package:icebox/widgets/sort_dialog.dart';
import 'package:provider/provider.dart';

class FreezerItemsScreen extends StatelessWidget {
  static const String routeName = '/freezer-items';

  const FreezerItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final freezerItems = context.watch<FreezerItems>();

    final multipleCategories = freezerItems.items.map((e) => e.category).toSet().length > 1;
    final multipleFreezers = freezerItems.items.map((e) => e.freezerId).toSet().length > 1;

    return FutureBuilder(
      future: _load(context),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Freezer Items"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.ac_unit_outlined),
                  onPressed: multipleFreezers ? () => showDialog(
                    context: context,
                    builder: (ctx) => FreezerDialog(),
                  ).then((value) => freezerItems.limitFreezer(value)) : null,
                ),
                IconButton(
                  icon: const Icon(Icons.category),
                  onPressed: multipleCategories ? () => showDialog(
                    context: context,
                    builder: (ctx) => CategoryDialog(),
                  ).then((value) => freezerItems.limitCategory(value)) : null,
                ),
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => SortDialog(freezerItems.sortBy),
                  ).then((value) => freezerItems.sortingBy(value)),
                ),
              ],
            ),
            drawer: AppDrawer(),
            // FIXME: the empty behavior should be moved into the FreezerItemList so that the search bar is still there
            body: freezerItems.isNotEmpty
                ? FreezerItemList()
                : const Center(child: Text('No freezer items.')),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(FreezerItemScreen.routeName),
            ),
          );
        }
        return _loadingWidget(context);
      },
    );
  }

  Future<void> _load(final BuildContext context) async {
    await context.read<Freezers>().load();
    await context.read<FreezerItems>().load();
  }

  Widget _loadingWidget(final BuildContext context) {
    // FIXME: give this more of a disabled look
    return Scaffold(
      appBar: AppBar(
        title: const Text("Freezer Items"),
        actions: [
          IconButton(
              icon: const Icon(Icons.ac_unit_outlined),
              onPressed: () {
                // nothing
              }),
          IconButton(
              icon: const Icon(Icons.category),
              onPressed: () {
                // nothing
              }),
          IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                // nothing
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // nothing
        },
      ),
    );
  }
}
