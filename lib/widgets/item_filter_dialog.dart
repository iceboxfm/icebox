import 'package:flutter/material.dart';

class ItemFilterDialog extends StatelessWidget {
  final List<ListTile> _items;

  const ItemFilterDialog(this._items);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            // title
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: const Text(
                'Show only...',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // list items
            Expanded(
              child: ListView(
                children: _items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
