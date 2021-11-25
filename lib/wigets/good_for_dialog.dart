import 'package:flutter/material.dart';

class GoodForDialog extends StatelessWidget {
  const GoodForDialog({Key? key}) : super(key: key);

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
              child: const Text(
                'Select item type...',
                // style: Theme.of(context).appBarTheme.textTheme.headline6,
              ),
            ),
            // list items
            SizedBox(
              height: 345,
              child: ListView(
                children: const [
                  GoodForItem('Bacon', '1 month', 1),
                  GoodForItem('Baked goods', '3 months', 3),
                  GoodForItem('Dough', '1 month', 1),
                  GoodForItem('Eggs, liquid unopened', '1 year', 12),
                  GoodForItem('Eggs, raw', '1 year', 12),
                  GoodForItem('Fish, cooked', '5 months', 5),
                  GoodForItem('Fish, fatty', '3 months', 3),
                  GoodForItem('Fish, lean', '8 months', 8),
                  GoodForItem('Fish, smoked', '2 months', 2),
                  GoodForItem('Fruits & Juices', '1 year', 12),
                  GoodForItem('Ham, cooked', '1 month', 1),
                  GoodForItem('Hot dogs', '2 months', 2),
                  GoodForItem('Lunch meats', '1 months', 1),
                  GoodForItem('Meat, fresh', '6 months', 6),
                  GoodForItem('Meat, ground', '3 months', 3),
                  GoodForItem('Meat, leftovers', '3 months', 3),
                  GoodForItem('Nuts', '3 months', 3),
                  GoodForItem('Poultry, cooked', '6 months', 6),
                  GoodForItem('Poultry, fresh', '3 months', 3),
                  GoodForItem('Sausage, raw or smoked', '2 months', 2),
                  GoodForItem('Seafood, canned', '2 months', 2),
                  GoodForItem('Soups & Stews', '3 months', 3),
                  GoodForItem('Vegetables', '8 months', 8),
                ].map((e) => SelectionItemTile(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoodForItem {
  final String name;
  final String time;
  final int value;

  const GoodForItem(this.name, this.time, this.value);
}

class SelectionItemTile extends StatelessWidget {
  final GoodForItem _item;

  const SelectionItemTile(this._item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(_item.name),
            const Spacer(),
            Text(_item.time),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pop(_item.value);
      },
    );
  }
}
