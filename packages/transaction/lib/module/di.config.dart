// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:service/service.dart' as _i736;
import 'package:transaction/data/repository/category_repository_impl.dart'
    as _i213;
import 'package:transaction/data/repository/expense_repository_impl.dart'
    as _i563;
import 'package:transaction/domain/repository/category_repository.dart'
    as _i660;
import 'package:transaction/domain/repository/expense_repository.dart' as _i439;
import 'package:transaction/domain/usecase/category/create_category_usecase.dart'
    as _i717;
import 'package:transaction/domain/usecase/category/delete_category_usecase.dart'
    as _i604;
import 'package:transaction/domain/usecase/category/get_categories_usecase.dart'
    as _i536;
import 'package:transaction/domain/usecase/category/get_category_usecase.dart'
    as _i996;
import 'package:transaction/domain/usecase/category/update_category_usecase.dart'
    as _i158;
import 'package:transaction/domain/usecase/expense/create_expense_usecase.dart'
    as _i119;
import 'package:transaction/domain/usecase/expense/delete_expense_usecase.dart'
    as _i172;
import 'package:transaction/domain/usecase/expense/get_expense_usecase.dart'
    as _i378;
import 'package:transaction/domain/usecase/expense/get_expenses_usecase.dart'
    as _i146;
import 'package:transaction/domain/usecase/expense/update_expense_usecase.dart'
    as _i974;
import 'package:transaction/domain/usecase/usecases.dart' as _i60;
import 'package:transaction/presentation/bloc/category/category_bloc.dart'
    as _i226;
import 'package:transaction/presentation/bloc/expense/expense_bloc.dart'
    as _i797;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt transaction(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i439.ExpenseRepository>(
    () => _i563.ExpenseRepositoryImpl(gh<_i736.IRestClient>()),
  );
  gh.lazySingleton<_i660.CategoryRepository>(
    () => _i213.CategoryRepositoryImpl(gh<_i736.IRestClient>()),
  );
  gh.lazySingleton<_i717.CreateCategoryUseCase>(
    () => _i717.CreateCategoryUseCase(gh<_i660.CategoryRepository>()),
  );
  gh.lazySingleton<_i604.DeleteCategoryUseCase>(
    () => _i604.DeleteCategoryUseCase(gh<_i660.CategoryRepository>()),
  );
  gh.lazySingleton<_i536.GetCategoriesUseCase>(
    () => _i536.GetCategoriesUseCase(gh<_i660.CategoryRepository>()),
  );
  gh.lazySingleton<_i996.GetCategoryUseCase>(
    () => _i996.GetCategoryUseCase(gh<_i660.CategoryRepository>()),
  );
  gh.lazySingleton<_i158.UpdateCategoryUseCase>(
    () => _i158.UpdateCategoryUseCase(gh<_i660.CategoryRepository>()),
  );
  gh.factory<_i226.CategoryBloc>(
    () => _i226.CategoryBloc(
      gh<_i60.GetCategoriesUseCase>(),
      gh<_i60.CreateCategoryUseCase>(),
      gh<_i60.UpdateCategoryUseCase>(),
      gh<_i60.DeleteCategoryUseCase>(),
    ),
  );
  gh.lazySingleton<_i119.CreateExpenseUseCase>(
    () => _i119.CreateExpenseUseCase(gh<_i439.ExpenseRepository>()),
  );
  gh.lazySingleton<_i172.DeleteExpenseUseCase>(
    () => _i172.DeleteExpenseUseCase(gh<_i439.ExpenseRepository>()),
  );
  gh.lazySingleton<_i378.GetExpenseUseCase>(
    () => _i378.GetExpenseUseCase(gh<_i439.ExpenseRepository>()),
  );
  gh.lazySingleton<_i146.GetExpensesUseCase>(
    () => _i146.GetExpensesUseCase(gh<_i439.ExpenseRepository>()),
  );
  gh.lazySingleton<_i974.UpdateExpenseUseCase>(
    () => _i974.UpdateExpenseUseCase(gh<_i439.ExpenseRepository>()),
  );
  gh.factory<_i797.ExpenseBloc>(
    () => _i797.ExpenseBloc(
      gh<_i60.GetExpensesUseCase>(),
      gh<_i60.CreateExpenseUseCase>(),
      gh<_i60.UpdateExpenseUseCase>(),
      gh<_i60.DeleteExpenseUseCase>(),
    ),
  );
  return getIt;
}
