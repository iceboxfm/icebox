import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/util/snack_bars.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

class ExportTab extends StatefulWidget {
  const ExportTab({Key? key}) : super(key: key);

  @override
  State<ExportTab> createState() => _ExportTabState();
}

class _ExportTabState extends State<ExportTab> with UiLoggy {
  String? _folder;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Select the location where you want to export your freezer data. '
            'Your data will be stored in a text file (.json extension) inside '
            'the selected folder.',
            style: TextStyle(fontSize: 18),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 35,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    _folder ?? 'No directory specified.',
                    style: TextStyle(
                      color: _folder == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('Pick'),
                onPressed: () =>
                    FilePicker.platform.getDirectoryPath().then((dir) {
                  setState(() => _folder = dir);
                }),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Export'),
                onPressed:
                    _folder != null ? () => _performExport(context) : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performExport(final BuildContext context) {
    final file = 'icebox-${DateTime.now().millisecondsSinceEpoch}.json';
    loggy.info('Exporting file ($file) to folder ($_folder).');

    final content = _buildExportContent(context);
    loggy.info('Exported: $content');

    File('$_folder/$file').writeAsString(content).then((f) {
      showMessageSnack(
        context,
        'Your data has been exported to:\n${f.path}.',
        6,
      );
    });
  }

  String _buildExportContent(final BuildContext context) {
    final freezersJson = jsonEncode(context.read<Freezers>().freezers);
    final freezerItemsJson = jsonEncode(context.read<FreezerItems>().items);
    return '{"freezers":$freezersJson, "freezerItems":$freezerItemsJson}';
  }
}
