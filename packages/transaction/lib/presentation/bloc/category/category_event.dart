part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class LoadCategories extends CategoryEvent {}

final class CreateCategory extends CategoryEvent {
  CreateCategory(this.param);

  final CreateCategoryParam param;
}

final class UpdateCategory extends CategoryEvent {
  UpdateCategory(this.param);

  final UpdateCategoryParam param;
}

final class DeleteCategory extends CategoryEvent {
  DeleteCategory(this.id);

  final String id;
}
