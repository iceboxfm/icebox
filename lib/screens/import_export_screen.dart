import 'package:flutter/material.dart';
import 'package:icebox/widgets/app_drawer.dart';
import 'package:icebox/widgets/export_tab.dart';

class ImportExportScreen extends StatelessWidget {
  static const String routeName = '/import-export';

  const ImportExportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Export / Import'),
          bottom: TabBar(
            automaticIndicatorColorAdjustment: true,
            indicatorColor: Theme.of(context).selectedRowColor,
            indicatorWeight: 4,
            tabs: const [
              Tab(icon: Icon(Icons.save_outlined), text: 'Export'),
              Tab(icon: Icon(Icons.file_download_outlined), text: 'Import'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ExportTab(),
            Center(child: Text('importing...')),
          ],
        ),
      ),
    );
  }
}
