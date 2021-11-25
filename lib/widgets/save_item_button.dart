import 'package:flutter/material.dart';

class SaveItemButton extends StatelessWidget {

  final bool enabled;
  final Function onPressed;

  const SaveItemButton({
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          enabled ? Colors.green.shade500 : Colors.black12,
        ),
      ),
      icon: const Icon(Icons.save),
      label: const Text('Save'),
      onPressed: () {
        if(enabled){
          onPressed();
        }
      },
    );
  }
}
