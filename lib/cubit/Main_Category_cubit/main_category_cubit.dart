import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'main_category_state.dart';

class MainCategoryCubit extends Cubit<MainCategoryState> {
  MainCategoryCubit() : super(MainCategoryInitial());

  final firestoreServices = FirestoreServices.instance;

  Future<void> getCategories() async {
    emit(MainCategoryLoading());
    try {
      final categories = await firestoreServices.getCollection<CategoryModel>(
        path: ApiPaths.categories(),
        builder: (data, documentId) => CategoryModel.fromMap(data),
      );
      emit(MainCategorySuccessLoaded(categories));
    } catch (e) {
      emit(MainCategoryFailure(e.toString()));
    }
  }
}
