import 'package:flutter/material.dart';
import 'package:icebox/widgets/delete_confirmation_dialog.dart';

class DeleteItemButton extends StatelessWidget {
  final Function onDelete;

  const DeleteItemButton({
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade400),
      ),
      icon: const Icon(Icons.delete),
      label: const Text('Delete'),
      onPressed: () => showDialog(
        context: context,
        builder: (ctx) => const DeleteConfirmationDialog(),
      ).then(
        (confirmed) {
          if (confirmed) {
            onDelete();
          }
        },
      ),
    );
  }
}
