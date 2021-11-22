class Freezer {
  final int? id;
  final String description;
  final List<String> shelves;

  Freezer({
    this.id,
    required this.description,
    required this.shelves,
  });

  Freezer copyWith({
    int? id,
    String? description,
    List<String>? shelves,
  }) =>
      Freezer(
        id: id ?? this.id,
        description: description ?? this.description,
        shelves: shelves ?? this.shelves,
      );

  @override
  String toString() =>
      'Freezer{id:"$id", description:"$description", shelves:$shelves}';

  static List<Freezer> sort(final List<Freezer> items,
      [final bool reversed = false]) {
    var workingItems = [...items];

    workingItems.sort((a, b) {
      return a.description.compareTo(b.description);
    });

    return reversed ? workingItems.reversed.toList() : workingItems;
  }
}
