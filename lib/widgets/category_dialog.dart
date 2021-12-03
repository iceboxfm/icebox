import 'package:flutter/material.dart';
import 'package:icebox/models/item_categories.dart';

// FIXME: come up with a shared dialog with good theming

class CategoryDialog extends StatelessWidget {
  final List<ItemCategory> selectedCategories;

  CategoryDialog(final Set<ItemCategory> categories)
      : selectedCategories = _sorted(categories);

  static List<ItemCategory> _sorted(final Set<ItemCategory> set){
    final List<ItemCategory> list = [...set];
    list.sort();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // title
            Container(
              padding: const EdgeInsets.all(6),
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: const Text('Show only...'),
            ),
            // list items
            SizedBox(
              height: 355,
              child: ListView(
                children: selectedCategories
                    .map((e) => ListTile(
                          leading: e.image,
                          title: Text(e.label),
                          onTap: () => Navigator.pop(context, e),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
