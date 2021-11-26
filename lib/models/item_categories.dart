import 'package:flutter/widgets.dart';

class ItemCategories {
  static const categories = [
    ItemCategory('No Category', 'assets/images/food-tray.png'),
    ItemCategory('Baked Goods', 'assets/images/baking.png'),
    ItemCategory('Dairy', 'assets/images/dairy-products.png'),
    ItemCategory('Fish', 'assets/images/fish.png'),
    ItemCategory('Frozen Meals', 'assets/images/ready-meal.png'),
    ItemCategory('Fruit', 'assets/images/fruits.png'),
    ItemCategory('Leftovers', 'assets/images/chicken.png'),
    ItemCategory('Meat - Beef', 'assets/images/beef.png'),
    ItemCategory('Meat - Poultry', 'assets/images/poultry.png'),
    ItemCategory('Meat - Pork', 'assets/images/ham.png'),
    ItemCategory('Meat - Other', 'assets/images/cold-meat.png'),
    ItemCategory('Nuts', 'assets/images/nuts.png'),
    ItemCategory('Soups & Sauces', 'assets/images/soy-sauce.png'),
    ItemCategory('Staples', 'assets/images/wheat.png'),
    ItemCategory('Vegetables', 'assets/images/vegetable.png'),
  ];

  static ItemCategory find(final String? label) {
    if (label == null || label.isEmpty) {
      return categories[0];
    }
    return categories.firstWhere((cat) => cat.label == label);
  }
}

// FIXME: needs to be comparable
class ItemCategory implements Comparable<ItemCategory> {
  final String label;
  final String imagePath;

  const ItemCategory(this.label, this.imagePath);

  Image get image {
    return Image(image: AssetImage(imagePath), width: 40);
  }

  @override
  bool operator ==(Object other) =>
      other is ItemCategory &&
          other.label == label &&
          other.imagePath == imagePath;

  @override
  int get hashCode => hashValues(label, imagePath);

  @override
  String toString() => 'ItemCategory(label:$label, imagePath:$imagePath)';

  @override
  int compareTo(final ItemCategory other) {
    return label.compareTo(other.label);
  }
}
