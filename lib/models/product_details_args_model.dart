import 'package:ecommerce_app/models/product_item_model.dart';

class ProductDetailsArgsModel {
  final String id;
  final ProductItemModel? productItemModel;

  ProductDetailsArgsModel({required this.id, this.productItemModel});
}
