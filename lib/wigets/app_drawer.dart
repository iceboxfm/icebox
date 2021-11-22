import 'package:flutter/material.dart';
import 'package:icebox/screens/freezer_items_screen.dart';
import 'package:icebox/screens/freezers_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  // FIXME: consider refactoring this to a future-builder

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            // FIXME: add an icon?
            title: const Text('Icebox'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.assignment_outlined),
            title: const Text('Freezer Items'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(FreezerItemsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.ac_unit_outlined),
            title: const Text('Freezers'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(FreezersScreen.routeName);
            },
          ),
          // const Divider(),
          // FIXME: impl
          // const AboutApp(),
          // const Divider(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'v${_packageInfo.version}',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }
}
