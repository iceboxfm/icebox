import 'package:flutter/material.dart';

import '../models/sort_by.dart';

class SortDialog extends StatefulWidget {
  final SortBy _sortBy;

  const SortDialog(this._sortBy);

  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  SortBy? _sortBy;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      _sortBy = widget._sortBy;
      _initialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 380,
        child: Column(
          children: [
            // title
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: const Text(
                'Sort by...',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // list items
            Expanded(
              child: ListView(
                children: [
                  RadioListTile<SortByField>(
                    title: const Text('Description'),
                    value: SortByField.description,
                    groupValue: _sortBy!.field,
                    onChanged: (sortField) => setState(() {
                      _sortBy = _sortBy!.withField(sortField);
                    }),
                  ),
                  RadioListTile<SortByField>(
                    title: const Text('Date Frozen'),
                    value: SortByField.frozenOn,
                    groupValue: _sortBy!.field,
                    onChanged: (sortField) => setState(() {
                      _sortBy = _sortBy!.withField(sortField);
                    }),
                  ),
                  RadioListTile<SortByField>(
                    title: const Text('Category'),
                    value: SortByField.category,
                    groupValue: _sortBy!.field,
                    onChanged: (sortField) => setState(() {
                      _sortBy = _sortBy!.withField(sortField);
                    }),
                  ),
                  RadioListTile<SortByField>(
                    title: const Text('Time Remaining'),
                    value: SortByField.timeRemaining,
                    groupValue: _sortBy!.field,
                    onChanged: (sortField) => setState(() {
                      _sortBy = _sortBy!.withField(sortField);
                    }),
                  ),
                  const Divider(),
                  CheckboxListTile(
                    title: const Text('Reversed Direction?'),
                    value: _sortBy!.reversed,
                    onChanged: (rev) => setState(() {
                      _sortBy = _sortBy!.withToggledReverse();
                    }),
                  ),
                ],
              ),
            ),
            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(_sortBy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
