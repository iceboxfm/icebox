import 'package:icebox/models/item_categories.dart';
import 'package:test/test.dart';

void main() {
  test('Test finding a category', () {
    expect(ItemCategories.find(null), ItemCategories.categories[0]);
    expect(ItemCategories.find(''), ItemCategories.categories[0]);
    expect(ItemCategories.find('Frozen Meals'), ItemCategories.categories[4]);
    expect(ItemCategories.find('No Category'), ItemCategories.categories[0]);
    expect(ItemCategories.find('Nuts'), ItemCategories.categories[11]);
  });

  test('Ensure they compare properly', () {
    expect(
      ItemCategories.categories[1].compareTo(ItemCategories.categories[5]),
      -1,
    );

    expect(
      ItemCategories.categories[6].compareTo(ItemCategories.categories[6]),
      0,
    );

    expect(
      ItemCategories.categories[5].compareTo(ItemCategories.categories[1]),
      1,
    );
  });

  test('Equals works right', () {
    expect(ItemCategories.categories[9] == ItemCategories.categories[9], true);
    expect(ItemCategories.categories[3] == ItemCategories.categories[8], false);
  });

  test('Rendering as a string', () {
    expect(
      ItemCategories.categories[5].toString(),
      'ItemCategory(label:Fruit, imagePath:assets/images/fruits.png)',
    );
  });
}
