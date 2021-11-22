import 'package:flutter/material.dart';
import 'package:icebox/wigets/app_drawer.dart';

class FreezersScreen extends StatelessWidget {
  static const String routeName = '/freezers';

  const FreezersScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Freezers"),
      ),
      drawer: AppDrawer(),
      body: const Center(child: Text('Freezers listed here.')),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () => Navigator.of(context).pushNamed(ItemScreen.routeName),
      // ),
    );
  }
}
