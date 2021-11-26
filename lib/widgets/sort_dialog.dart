import 'package:flutter/material.dart';

import '../models/sort_by.dart';

// FIXME: needs theme and visual work

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // title
            Container(
              padding: const EdgeInsets.all(6),
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: const Text('Sort items by...'),
            ),
            // list items
            SizedBox(
              height: 295,
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
