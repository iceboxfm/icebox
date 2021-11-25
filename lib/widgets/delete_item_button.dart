import 'package:flutter/material.dart';

class DeleteItemButton extends StatelessWidget {
  final Function onDelete;

  const DeleteItemButton({
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade400 ),
      ),
      icon: const Icon(Icons.delete),
      label: const Text('Delete'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => buildAlertDialog(ctx),
        ).then((confirmed) {
          if (confirmed) {
            onDelete();
          }
        });
      },
    );
  }

  AlertDialog buildAlertDialog(final BuildContext ctx) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to permanently delete this item?'),
      actions: [
        TextButton(
          child: const Text('No'),
          onPressed: () => Navigator.of(ctx).pop(false),
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    );
  }
}
