import 'package:flutter/material.dart';

class QuantityDialog extends StatefulWidget {
  final String? description;
  final String? quantity;

  const QuantityDialog(this.description, this.quantity);

  @override
  _QuantityDialogState createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.quantity!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('Quantity of ${widget.description}'),
      content: TextField(
        autofocus: true,
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Quantity'),
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
