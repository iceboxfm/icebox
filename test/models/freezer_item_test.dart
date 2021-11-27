import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/models/item_categories.dart';
import 'package:icebox/models/sort_by.dart';
import 'package:test/test.dart';

void main() {
  final itemFrozenOn = DateTime.parse('2021-10-21 09:21:22');
  final item = FreezerItem(
    id: 1,
    description: 'Chicken parts',
    quantity: 'a bunch',
    frozenOn: itemFrozenOn,
    goodFor: 4,
    category: ItemCategories.categories[8],
    location: 'Middle shelf',
    freezerId: 10,
  );

  test('Testing string representation', () {
    expect(
      item.toString(),
      'FreezerItem(id:1, description:"Chicken parts", location:"Middle shelf", category:"Meat - Poultry", quantity:"a bunch", frozenOn:2021-10-21 09:21:22.000, goodFor:4, freezerId:10)',
    );
  });

  test('Testing time remaining', () {
    final item = FreezerItem(
      id: 2,
      description: 'Chicken parts',
      quantity: 'a bunch',
      frozenOn: DateTime.now().subtract(const Duration(days: 65)),
      goodFor: 4,
      category: ItemCategories.categories[8],
      location: 'Middle shelf',
      freezerId: 10,
    );

    expect(item.timeRemaining.inDays, 55);
  });

  test('Testing copy-with', () {
    expect(
        item.copyWith(id: 3),
        FreezerItem(
          id: 3,
          description: 'Chicken parts',
          quantity: 'a bunch',
          frozenOn: itemFrozenOn,
          goodFor: 4,
          category: ItemCategories.categories[8],
          location: 'Middle shelf',
          freezerId: 10,
        ));

    expect(
        item.copyWith(description: 'different food'),
        FreezerItem(
          id: 1,
          description: 'different food',
          quantity: 'a bunch',
          frozenOn: itemFrozenOn,
          goodFor: 4,
          category: ItemCategories.categories[8],
          location: 'Middle shelf',
          freezerId: 10,
        ));

    expect(
        item.copyWith(quantity: 'a few'),
        FreezerItem(
          id: 1,
          description: 'Chicken parts',
          quantity: 'a few',
          frozenOn: itemFrozenOn,
          goodFor: 4,
          category: ItemCategories.categories[8],
          location: 'Middle shelf',
          freezerId: 10,
        ));

    expect(
        item.copyWith(location: 'Bottom shelf'),
        FreezerItem(
          id: 1,
          description: 'Chicken parts',
          quantity: 'a bunch',
          frozenOn: itemFrozenOn,
          goodFor: 4,
          category: ItemCategories.categories[8],
          location: 'Bottom shelf',
          freezerId: 10,
        ));

    final now = DateTime.now();
    expect(
        item.copyWith(frozenOn: now),
        FreezerItem(
          id: 1,
          description: 'Chicken parts',
          quantity: 'a bunch',
          frozenOn: now,
          goodFor: 4,
          category: ItemCategories.categories[8],
          location: 'Middle shelf',
          freezerId: 10,
        ));

    expect(
        item.copyWith(goodFor: 10),
        FreezerItem(
          id: 1,
          description: 'Chicken parts',
          quantity: 'a bunch',
          frozenOn: itemFrozenOn,
          goodFor: 10,
          category: ItemCategories.categories[8],
          location: 'Middle shelf',
          freezerId: 10,
        ));

    expect(
        item.copyWith(category: ItemCategories.categories[0]),
        FreezerItem(
          id: 1,
          description: 'Chicken parts',
          quantity: 'a bunch',
          frozenOn: itemFrozenOn,
          goodFor: 4,
          category: ItemCategories.categories[0],
          location: 'Middle shelf',
          freezerId: 10,
        ));

    // test with two changes
    expect(
      item.copyWith(quantity: '1 lb', location: 'Upper drawer'),
      FreezerItem(
        id: 1,
        description: 'Chicken parts',
        quantity: '1 lb',
        frozenOn: itemFrozenOn,
        goodFor: 4,
        category: ItemCategories.categories[8],
        location: 'Upper drawer',
        freezerId: 10,
      ),
    );
  });

  test('Testing sorting', () {
    final alpha = FreezerItem(
      id: 1,
      description: 'Chicken parts',
      quantity: '1',
      frozenOn: DateTime.parse('2021-10-21'),
      goodFor: 6,
      category: ItemCategories.categories[1],
      location: 'Middle shelf',
    );
    final bravo = FreezerItem(
      id: 2,
      description: 'Pig parts',
      quantity: '4',
      frozenOn: DateTime.parse('2021-10-19'),
      goodFor: 3,
      category: ItemCategories.categories[2],
      location: 'Middle shelf',
    );
    final charlie = FreezerItem(
      id: 3,
      description: 'Cow parts',
      quantity: '3',
      frozenOn: DateTime.parse('2021-10-20'),
      goodFor: 8,
      category: ItemCategories.categories[3],
      location: 'Middle shelf',
    );

    final items = [alpha, bravo, charlie];

    // description
    var sorted =
        FreezerItem.sort(items, const SortBy(SortByField.description, false));
    expect(sorted.map((e) => e.id).toList(), [1, 3, 2]);

    sorted =
        FreezerItem.sort(items, const SortBy(SortByField.description, true));
    expect(sorted.map((e) => e.id).toList(), [2, 3, 1]);

    // frozen-on
    sorted = FreezerItem.sort(items, const SortBy(SortByField.frozenOn, false));
    expect(sorted.map((e) => e.id).toList(), [2, 3, 1]);

    sorted = FreezerItem.sort(items, const SortBy(SortByField.frozenOn, true));
    expect(sorted.map((e) => e.id).toList(), [1, 3, 2]);

    // category
    sorted = FreezerItem.sort(items, const SortBy(SortByField.category, false));
    expect(sorted.map((e) => e.id).toList(), [1, 2, 3]);

    sorted = FreezerItem.sort(items, const SortBy(SortByField.category, true));
    expect(sorted.map((e) => e.id).toList(), [3, 2, 1]);
  });
}
