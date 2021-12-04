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
        if (snap.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Freezer Items"),
              actions: const [
                FreezerFilterButton(),
                ItemCategoryFilterButton(),
                FreezerItemSortButton(),
              ],
            ),
            drawer: const AppDrawer(),
            body: const FreezerItemList(),
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

  // FIXME: can this be done on app start?
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
