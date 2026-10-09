part of 'category_bloc.dart';

enum CategoryStatus { init, loading, success, error }

class CategoryState extends Equatable {
  const CategoryState({
    this.status = CategoryStatus.init,
    this.items = const [],
  });

  final CategoryStatus status;
  final Iterable<ICategoryEntity> items;

  @override
  List<Object?> get props => [status, items];

  CategoryState copyWith({
    CategoryStatus? newStatus,
    Iterable<ICategoryEntity>? newItems,
  }) {
    return CategoryState(status: newStatus ?? status, items: newItems ?? items);
  }
}
