import 'package:icebox/models/freezer.dart';
import 'package:test/test.dart';

void main() {
  final _freezer = Freezer(
    id: 3,
    description: 'Garage',
    shelves: ['Upper', 'Lower'],
    type: FreezerType.chest,
  );

  test('String representation', () {
    expect(_freezer.toString(),
        'Freezer{id:3, description:"Garage", type:chest, shelves:[Upper, Lower]}');
  });

  test('FreezerType from name', () {
    expect(FreezerTypeExt.forName('upright'), FreezerType.upright);
    expect(FreezerTypeExt.forName('chest'), FreezerType.chest);
    expect(FreezerTypeExt.forName('drawer'), FreezerType.drawer);
  });

  test('Copy with changes', () {
    expect(
      _freezer.copyWith(id: 7),
      Freezer(
        id: 7,
        description: 'Garage',
        shelves: ['Upper', 'Lower'],
        type: FreezerType.chest,
      ),
    );

    expect(
      _freezer.copyWith(description: 'Outside'),
      Freezer(
        id: 3,
        description: 'Outside',
        shelves: ['Upper', 'Lower'],
        type: FreezerType.chest,
      ),
    );

    expect(
      _freezer.copyWith(shelves: ['Body']),
      Freezer(
        id: 3,
        description: 'Garage',
        shelves: ['Body'],
        type: FreezerType.chest,
      ),
    );

    expect(
      _freezer.copyWith(type: FreezerType.upright),
      Freezer(
        id: 3,
        description: 'Garage',
        shelves: ['Upper', 'Lower'],
        type: FreezerType.upright,
      ),
    );

    expect(
      _freezer.copyWith(description: 'Shed', type: FreezerType.drawer),
      Freezer(
        id: 3,
        description: 'Shed',
        shelves: ['Upper', 'Lower'],
        type: FreezerType.drawer,
      ),
    );
  });
}
