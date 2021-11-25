import 'package:flutter/material.dart';
import 'package:icebox/wigets/good_for_dialog.dart';

class GoodForSelector extends StatefulWidget {
  final int? initialValue;
  final Function onSave;
  final Function onChanged;

  const GoodForSelector({
    this.initialValue,
    required this.onSave,
    required this.onChanged,
  });

  @override
  _GoodForSelectorState createState() =>
      _GoodForSelectorState(initialValue, onSave, onChanged);
}

class _GoodForSelectorState extends State<GoodForSelector> {
  int? _goodForValue;
  final Function _onSave;
  final Function _onChanged;

  _GoodForSelectorState(this._goodForValue, this._onSave, this._onChanged);

  @override
  Widget build(final BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: 'Good For',
        labelStyle: const TextStyle(color: Colors.blue),
        suffix: IconButton(
          icon: const Icon(Icons.lightbulb_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return const GoodForDialog();
              },
            ).then((value) {
              if (value != null) {
                setState(() {
                  _goodForValue = value;
                });
              }
            });
          },
        ),
      ),
      value: _goodForValue,
      items: [for (var i = 1; i <= 24; i++) i]
          .map((e) => DropdownMenuItem<int>(
                child: Text('$e months'),
                value: e,
                enabled: true,
              ))
          .toList(),
      onChanged: (value) => _onChanged(value),
      onSaved: (value) => _onSave(value),
    );
  }
}
