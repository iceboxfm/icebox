import 'package:flutter/material.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/wigets/app_drawer.dart';

class FreezerItemsScreen extends StatelessWidget {
  static const String routeName = '/freezer-items';

  const FreezerItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Freezer Items"),
        // FIXME: implement
        // FIXME: also add ability to limit view to one freezer
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.category),
        //     onPressed: () => showDialog(
        //       context: context,
        //       builder: (ctx) => CategoryDialog(),
        //     ).then((value) => freezerItems.limitCategory(value)),
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.sort),
        //     onPressed: () => showDialog(
        //       context: context,
        //       builder: (ctx) => SortDialog(freezerItems.sortBy),
        //     ).then((value) => freezerItems.sortingBy(value)),
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () => freezerItems.filteringBy(''),
        //   ),
        // ],
      ),
      drawer: AppDrawer(),
      body: const Center(child: Text('Freezer items listed here.')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(FreezerItemScreen.routeName),
      ),
    );
  }
}
