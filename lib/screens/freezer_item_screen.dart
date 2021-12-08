import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/models/item_categories.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/widgets/delete_item_button.dart';
import 'package:icebox/widgets/good_for_selector.dart';
import 'package:icebox/widgets/save_item_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// The screen for creating/editing freezer item information
class FreezerItemScreen extends StatefulWidget {
  static const routeName = '/freezer-item';

  const FreezerItemScreen({Key? key}) : super(key: key);

  @override
  _FreezerItemScreenState createState() => _FreezerItemScreenState();
}

class _FreezerItemScreenState extends State<FreezerItemScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  bool _isInit = true;
  bool _editing = false;
  bool _canSave = true;
  int? _freezerId;
  String _itemLocation = '';
  FreezerItem _freezerItem = FreezerItem(
    description: '',
    quantity: '',
    frozenOn: DateTime.now(),
    goodFor: 3,
    category: ItemCategories.categories[0],
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final editing =
          ModalRoute.of(context)!.settings.arguments as FreezerItem?;
      if (editing != null) {
        _editing = true;
        _canSave = false;
        _freezerItem = editing;
        _freezerId = editing.freezerId;
        _itemLocation = editing.location ?? '';
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(final BuildContext context) {
    final freezerItems = context.read<FreezerItems>();
    final freezers = context.read<Freezers>();

    _typeAheadController.value = TextEditingValue(text: _itemLocation);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezer Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  autofocus: _freezerItem.description.isEmpty,
                  decoration: _fieldLabel('Description', 'What is it?'),
                  initialValue: _freezerItem.description,
                  maxLength: 50,
                  validator: (value) => _validateNotEmpty(
                    value,
                    'A description is required.',
                  ),
                  onChanged: (_) => setState(() => _canSave = true),
                  onSaved: (value) =>
                      _freezerItem = _freezerItem.copyWith(description: value),
                ),
                TextFormField(
                  decoration: _fieldLabel('Quantity', 'How much do you have?'),
                  initialValue: _freezerItem.quantity,
                  maxLength: 50,
                  validator: (value) => _validateNotEmpty(
                    value,
                    'A quantity is required.',
                  ),
                  onChanged: (_) => setState(() => _canSave = true),
                  onSaved: (value) =>
                      _freezerItem = _freezerItem.copyWith(quantity: value),
                ),
                DropdownButtonFormField<String>(
                  decoration: _fieldLabel('Category', null),
                  value: _freezerItem.category.label,
                  items: _categoryItems(),
                  onChanged: (_) => setState(() => _canSave = true),
                  onSaved: (value) => _freezerItem = _freezerItem.copyWith(
                    category: ItemCategories.find(value!),
                  ),
                ),
                DropdownButtonFormField<int>(
                  decoration: _fieldLabel('Freezer', null),
                  value: _freezerItem.freezerId ?? _defaultFreezer(freezers),
                  items: _availableFreezers(context),
                  onChanged: (value) => setState(() {
                    _freezerId = value;
                    _canSave = true;
                  }),
                  onSaved: (value) => _freezerItem = _freezerItem.copyWith(
                    freezerId: value,
                  ),
                ),
                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: _fieldLabel('Location', 'Where is it?'),
                  ),
                  itemBuilder: (ctx, sugg) => ListTile(
                    title: Text(sugg.toString()),
                  ),
                  suggestionsCallback: (pattern) {
                    final pat = pattern.toLowerCase();
                    return freezers
                        .retrieve(_freezerId ?? _defaultFreezer(freezers)!)
                        .shelves
                        .where((s) => s.toLowerCase().contains(pat));
                  },
                  onSuggestionSelected: (sugg) {
                    setState(() {
                      _itemLocation = sugg.toString();
                      _canSave = true;
                    });
                  },
                  onSaved: (value) =>
                      _freezerItem = _freezerItem.copyWith(location: value),
                ),
                DateTimeField(
                  decoration: _fieldLabel('Date Frozen', null),
                  format: DateFormat('MMM dd yyyy'),
                  initialValue: _freezerItem.frozenOn,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 90)),
                      lastDate: DateTime.now(),
                    );
                  },
                  onChanged: (_) => setState(() => _canSave = true),
                  onSaved: (value) =>
                      _freezerItem = _freezerItem.copyWith(frozenOn: value),
                ),
                GoodForSelector(
                  initialValue: _freezerItem.goodFor,
                  onChanged: (_) => setState(() => _canSave = true),
                  onSave: (value) =>
                      _freezerItem = _freezerItem.copyWith(goodFor: value),
                ),
              ],
            ),
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
                onDelete: () => freezerItems
                    .delete(_freezerItem.id!)
                    .then((_) => Navigator.of(context).pop()),
              ),
            const Spacer(),
            SaveItemButton(
              enabled: _canSave,
              onPressed: () => _saveForm(freezerItems),
            ),
          ],
        ),
      ),
    );
  }

  int? _defaultFreezer(final Freezers freezers) {
    return freezers.freezers[0].id;
  }

  List<DropdownMenuItem<int>> _availableFreezers(final BuildContext context) {
    return context
        .read<Freezers>()
        .freezers
        .map((f) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  f.type.image!,
                  const SizedBox(width: 15),
                  Text(f.description),
                ],
              ),
              value: f.id,
              enabled: true,
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _categoryItems() {
    return ItemCategories.categories
        .map((cat) => DropdownMenuItem<String>(
              child: Row(
                children: [
                  cat.image,
                  const SizedBox(width: 15),
                  Text(cat.label),
                ],
              ),
              value: cat.label,
              enabled: true,
            ))
        .toList();
  }

  InputDecoration _fieldLabel(final String label, final String? hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
    );
  }

  String? _validateNotEmpty(final String? value, final String errorMsg) {
    if (value!.isEmpty) {
      return errorMsg;
    }
    return null;
  }

  void _saveForm(final FreezerItems freezerItems) {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      freezerItems.save(_freezerItem).then((_) => Navigator.of(context).pop());
    }
  }
}
