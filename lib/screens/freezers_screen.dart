import 'package:flutter/material.dart';
import 'package:icebox/screens/freezer_screen.dart';
import 'package:icebox/widgets/app_drawer.dart';
import 'package:icebox/widgets/freezer_list.dart';

class FreezersScreen extends StatelessWidget {
  static const String routeName = '/freezers';

  const FreezersScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezers'),
      ),
      drawer: const AppDrawer(),
      body: const FreezerList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(FreezerScreen.routeName),
      ),
    );
  }
}
