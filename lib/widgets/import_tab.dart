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
            'to import. New records will be added while any matching entries '
            'already existing in the database, will be updated.',
            style: TextStyle(fontSize: 18),
          ),
          const Divider(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orangeAccent),
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(6),
            child: const Text(
              'To avoid unexpected data loss, tt is recommended that you export '
              'your data, to use as a backup, before importing.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(),
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
    loggy.info('Importing file ($_file).');

    final content = await File(_file!).readAsString();
    loggy.info('Imported: $content');

    _import(context, content);
  }

  String _name(final String str, final int lastX) =>
      str.substring(str.lastIndexOf('/') + 1);

  Future<void> _import(final BuildContext context, final String json) async {
    if (json.isNotEmpty) {
      try {
        final map = jsonDecode(json);

        await context.read<Freezers>().importing(
              (map['freezers'] as List<dynamic>)
                  .map((f) => Freezer.fromJson(f))
                  .toList(),
            );

        await context.read<FreezerItems>().importing(
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
