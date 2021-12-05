import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String? itemLabel;

  const DeleteConfirmationDialog([this.itemLabel]);

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: _title(),
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
    );
  }

  Text _title() {
    return itemLabel != null
        ? Text('Do you want to permanently delete "$itemLabel"?')
        : const Text('Do you want to permanently delete this item?');
  }
}
