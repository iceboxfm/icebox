import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/widgets/app_drawer.dart';
import 'package:icebox/widgets/freezer_item_list.dart';
import 'package:provider/provider.dart';

class FreezerItemsScreen extends StatelessWidget {
  static const String routeName = '/freezer-items';

  const FreezerItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final freezerItems = context.watch<FreezerItems>();

    return FutureBuilder(
      future: _load(context),
      builder: (ctx, snap){
       if( snap.connectionState == ConnectionState.done){
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
           body: freezerItems.isNotEmpty
               ? FreezerItemList(freezerItems)
               : const Center(child: Text('Freezer items listed here.')),
           floatingActionButton: FloatingActionButton(
             child: const Icon(Icons.add),
             onPressed: () =>
                 Navigator.of(context).pushNamed(FreezerItemScreen.routeName),
           ),
         );
       }
       return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> _load(final BuildContext context) async {
    await context.read<Freezers>().load();
    await context.read<FreezerItems>().load();
  }
}
