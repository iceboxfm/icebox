import 'package:flutter/material.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/wigets/delete_item_button.dart';
import 'package:icebox/wigets/save_item_button.dart';
import 'package:icebox/wigets/shelf_editor_field.dart';
import 'package:provider/provider.dart';

/// The screen for creating/editing freezer information
class FreezerScreen extends StatefulWidget {
  static const routeName = '/freezer';

  const FreezerScreen({Key? key}) : super(key: key);

  @override
  _FreezerScreenState createState() => _FreezerScreenState();
}

class _FreezerScreenState extends State<FreezerScreen> {
  final _form = GlobalKey<FormState>();
  bool _isInit = true;
  bool _editing = false;
  bool _canSave = true;
  Freezer _freezer = Freezer(
    description: '',
    type: FreezerType.upright,
    shelves: [],
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final editing = ModalRoute.of(context)!.settings.arguments as Freezer?;
      if (editing != null) {
        _editing = true;
        _canSave = false;
        _freezer = editing;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final freezers = context.read<Freezers>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'What do you want to call this freezer?',
                ),
                autofocus: !_editing,
                validator: (value) => value == null || value.isEmpty
                    ? 'A description must be specified.'
                    : null,
                initialValue: _freezer.description,
                onChanged: (_) => setState(() => _canSave = true),
                onSaved: (value) =>
                    _freezer = _freezer.copyWith(description: value),
              ),
              DropdownButtonFormField<FreezerType>(
                decoration: const InputDecoration(
                  labelText: 'Freezer Type',
                  hintText: 'What kind of freezer do you have?',
                ),
                value: _freezer.type,
                items: [
                  DropdownMenuItem<FreezerType>(
                    child: Row(
                      children: [
                        FreezerType.upright.image!,
                        const SizedBox(width: 15),
                        const Text('Upright'),
                      ],
                    ),
                    value: FreezerType.upright,
                    enabled: true,
                  ),
                  DropdownMenuItem<FreezerType>(
                    child: Row(
                      children: [
                        FreezerType.chest.image!,
                        const SizedBox(width: 15),
                        const Text('Chest'),
                      ],
                    ),
                    value: FreezerType.chest,
                    enabled: true,
                  ),
                  DropdownMenuItem<FreezerType>(
                    child: Row(
                      children: [
                        FreezerType.drawer.image!,
                        const SizedBox(width: 15),
                        const Text('Drawer'),
                      ],
                    ),
                    value: FreezerType.drawer,
                    enabled: true,
                  ),
                ],
                onChanged: (_) => setState(() => _canSave = true),
                onSaved: (value) => _freezer = _freezer.copyWith(type: value),
              ),
              ShelfEditorField(
                initialValue: _freezer.shelves,
                onChanged: (_) => setState(() => _canSave = true),
                onSaved: (value) => _freezer = _freezer.copyWith(shelves: value),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_editing)
              DeleteItemButton(
                // FIXME: should not allow delete if there are items!
                onDelete: () => freezers
                    .delete(_freezer.id!)
                    .then((_) => Navigator.of(context).pop()),
              ),
            const Spacer(),
            SaveItemButton(
              enabled: _canSave,
              onPressed: () => _saveForm(freezers),
            ),
          ],
        ),
      ),
    );
  }

  void _saveForm(final Freezers freezers) {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      freezers.save(_freezer).then((_) => Navigator.of(context).pop());
    }
  }
}
