import 'package:flutter/material.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_screen.dart';
import 'package:icebox/widgets/app_drawer.dart';
import 'package:icebox/widgets/freezer_list.dart';
import 'package:provider/provider.dart';

class FreezersScreen extends StatelessWidget {
  static const String routeName = '/freezers';

  const FreezersScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final freezers = context.watch<Freezers>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezers'),
      ),
      drawer: const AppDrawer(),
      // FIXME: move this down into list view
      body: freezers.isNotEmpty
          ? FreezerList(freezers)
          : const Center(child: Text('You have no freezers.')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(FreezerScreen.routeName),
      ),
    );
  }
}
