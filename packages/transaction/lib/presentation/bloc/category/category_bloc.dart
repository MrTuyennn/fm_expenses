import 'package:app_logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:service/service.dart';
import 'package:transaction/domain/entities/entities.dart';
import 'package:transaction/domain/usecase/usecases.dart';

part 'category_event.dart';
part 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(
    this.getCategoriesUseCase,
    this.createCategoryUseCase,
    this.updateCategoryUseCase,
    this.deleteCategoryUseCase,
  ) : super(const CategoryState()) {
    on<LoadCategories>(_onLoad);
    on<CreateCategory>(_onCreate);
    on<UpdateCategory>(_onUpdate);
    on<DeleteCategory>(_onDelete);
  }

  final GetCategoriesUseCase getCategoriesUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  Future<void> _onLoad(LoadCategories event, Emitter emit) async {
    emit(state.copyWith(newStatus: CategoryStatus.loading));
    final result = await getCategoriesUseCase.call();
    result.when(
      success: (items) => emit(
        state.copyWith(newStatus: CategoryStatus.success, newItems: items),
      ),
      failure: (error) {
        logger.e(error);
        emit(state.copyWith(newStatus: CategoryStatus.error));
      },
    );
  }

  Future<void> _onCreate(CreateCategory event, Emitter emit) async {
    final result = await createCategoryUseCase.call(event.param);
    result.when(
      success: (_) => add(LoadCategories()),
      failure: (error) => logger.e(error),
    );
  }

  Future<void> _onUpdate(UpdateCategory event, Emitter emit) async {
    final result = await updateCategoryUseCase.call(event.param);
    result.when(
      success: (_) => add(LoadCategories()),
      failure: (error) => logger.e(error),
    );
  }

  Future<void> _onDelete(DeleteCategory event, Emitter emit) async {
    final result = await deleteCategoryUseCase.call(IdParam(event.id));
    result.when(
      success: (_) => add(LoadCategories()),
      failure: (error) => logger.e(error),
    );
  }
}
