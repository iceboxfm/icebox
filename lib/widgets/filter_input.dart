import 'package:flutter/material.dart';
import 'package:icebox/providers/freezer_items.dart';

class FilterInput extends StatefulWidget {
  final FreezerItems _freezerItems;

  const FilterInput(this._freezerItems);

  @override
  _FilterInputState createState() => _FilterInputState();
}

class _FilterInputState extends State<FilterInput> {
  final _controller = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1), // set border width
        borderRadius: const BorderRadius.all(
            Radius.circular(8.0)), // set rounded corner radius
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Filter by...',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              widget._freezerItems.filteringBy(null);
            },
          ),
        ),
        autofocus: false,
        onChanged: (value) => widget._freezerItems.filteringBy(value),
      ),
    );
  }
}
