import 'package:flutter/material.dart';

class ShelfNameDialog extends StatefulWidget {
  final String name;

  const ShelfNameDialog(this.name);

  @override
  _ShelfNameDialogState createState() => _ShelfNameDialogState();
}

class _ShelfNameDialogState extends State<ShelfNameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.name;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      title: const Text('Shelf Name'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'What do you want to call the shelf?'),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () => Navigator.pop(context, _controller.text),
        ),
      ],
    );
  }
}
