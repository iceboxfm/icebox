
enum SortByField { description, frozenOn, timeRemaining, category }

// TODO: unit test
class SortBy {
  final SortByField? field;
  final bool reversed;

  const SortBy(this.field, this.reversed);

  SortBy withField(SortByField? field){
    return SortBy(field, reversed);
  }

  SortBy withToggledReverse(){
    return SortBy(field, !reversed);
  }
}