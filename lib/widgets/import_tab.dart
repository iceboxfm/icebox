import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/util/snack_bars.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

class ImportTab extends StatefulWidget {
  const ImportTab({Key? key}) : super(key: key);

  @override
  State<ImportTab> createState() => _ImportTabState();
}

class _ImportTabState extends State<ImportTab> with UiLoggy {
  String? _file;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text(
            'Select the file (.json) containing the freezer data you want '
            'to import.',
            style: TextStyle(fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              border: Border.all(color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: const Text(
              'WARNING: All existing data will be cleared when the file is '
              'imported.\nBe sure you have exported the existing data if you want'
              ' to keep it.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepOrange,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 35,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    _file != null ? _name(_file!, 40) : 'No file specified.',
                    style: TextStyle(
                      color: _file == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('Pick'),
                onPressed: () => FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                ).then((res) {
                  if (res != null && res.isSinglePick) {
                    setState(() => _file = res.files.single.path);
                  }
                }),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Import'),
                onPressed: _file != null ? () => _performImport(context) : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performImport(final BuildContext context) async {
    final bool confirmed = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'By importing data the data file you will be clearing out all of your existing data',
        ),
        actions: [
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed) {
      loggy.info('Importing file ($_file).');

      final content = await File(_file!).readAsString();
      loggy.info('Imported: $content');

      _import(context, content);
    }
  }

  String _name(final String str, final int lastX) =>
      str.substring(str.lastIndexOf('/') + 1);

  Future<void> _import(final BuildContext context, final String json) async {
    if (json.isNotEmpty) {
      try {
        final freezers = context.read<Freezers>();
        final freezerItems = context.read<FreezerItems>();

        // clear the existing data
        await freezerItems.clear();
        await freezers.clear();

        final map = jsonDecode(json);

        await freezers.importing(
          (map['freezers'] as List<dynamic>)
              .map((f) => Freezer.fromJson(f))
              .toList(),
        );

        await freezerItems.importing(
          (map['freezerItems'] as List<dynamic>)
              .map((fi) => FreezerItem.fromJson(fi))
              .toList(),
        );

        showMessageSnack(context, 'The data has been imported.');
      } catch (ex) {
        loggy.error('Unable to import due to error: "$ex"', ex);
        showErrorSnack(context, 'Import failed due to error: "$ex".');
      }
    }
  }
}
