import 'package:flutter/material.dart';
import 'package:icebox/screens/freezer_items_screen.dart';
import 'package:icebox/screens/freezers_screen.dart';
import 'package:icebox/screens/import_export_screen.dart';
import 'package:icebox/widgets/about_app.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/ice-cubes.png'),
                  width: 40,
                ),
                Container(
                  child: const Text('Icebox'),
                  margin: const EdgeInsets.only(left: 8),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          const DrawerButton(
            Icons.assignment_outlined,
            'Freezer Items',
            FreezerItemsScreen.routeName,
          ),
          const Divider(),
          const DrawerButton(
            Icons.ac_unit_outlined,
            'Freezers',
            FreezersScreen.routeName,
          ),
          const Divider(),
          const DrawerButton(
            Icons.import_export_outlined,
            'Export / Import',
            ImportExportScreen.routeName,
          ),
          const Spacer(),
          const AboutApp(),
          const Divider(),
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

class DrawerButton extends StatelessWidget {
  final IconData _icon;
  final String _label;
  final String _route;

  const DrawerButton(this._icon, this._label, this._route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_icon),
      title: Text(
        _label,
        style: const TextStyle(fontSize: 18),
      ),
      onTap: () => Navigator.of(context).pushReplacementNamed(_route),
    );
  }
}
