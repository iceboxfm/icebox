import 'package:flutter/material.dart';
import 'package:icebox/widgets/shelf_name_dialog.dart';

class ShelfEditorField extends FormField<List<String>> {
  ShelfEditorField({
    required List<String> initialValue,
    required FormFieldSetter<List<String>> onSaved,
    required Function onChanged,
  }) : super(
    initialValue: initialValue,
    onSaved: onSaved,
    builder: (FormFieldState<List<String>> state) {
      final shelves = state.value!;

      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Shelves'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: state.context,
                        builder: (ctx) => const ShelfNameDialog(''),
                      ).then((value) {
                        if (value != null &&
                            (value as String).isNotEmpty) {
                          state.didChange([...shelves, value]);
                          onChanged(value);
                        }
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black26),
                  ),
                  width: double.infinity,
                  child: ReorderableListView(
                    children: shelves.asMap().map((idx, shelfName) =>
                        MapEntry(idx, ListTile(
                          key: ValueKey(shelfName),
                          title: Text(shelfName),
                          leading: const Icon(Icons.drag_handle_outlined),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear_outlined),
                            onPressed: () {
                              state.didChange([...shelves]..removeAt(idx));
                              onChanged(null);
                            },
                          ),
                          onTap: () {
                            showDialog(
                              context: state.context,
                              builder: (ctx) => ShelfNameDialog(shelfName),
                            ).then((value) {
                              if (value != null && (value as String).isNotEmpty) {
                                state.didChange([...shelves]
                                  ..removeAt(idx)
                                  ..insert(idx, value));
                                onChanged(value);
                              }
                            });
                          },
                        ),),).values.toList(),
                    onReorder: (oldIdx, newIdx) {
                      if (oldIdx < newIdx) {
                        newIdx -= 1;
                      }

                      final newShelves = [...shelves];
                      newShelves.insert(newIdx, newShelves.removeAt(oldIdx));

                      state.didChange(newShelves);
                      onChanged(null);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
