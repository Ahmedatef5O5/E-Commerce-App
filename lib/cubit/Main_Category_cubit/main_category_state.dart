part of 'main_category_cubit.dart';

sealed class MainCategoryState {}

final class MainCategoryInitial extends MainCategoryState {}

final class MainCategoryLoading extends MainCategoryState {}

final class MainCategorySuccessLoaded extends MainCategoryState {
  final List<CategoryModel> categories;

  MainCategorySuccessLoaded(this.categories);
}

final class MainCategoryFailure extends MainCategoryState {
  final String errMsg;

  MainCategoryFailure(this.errMsg);
}
