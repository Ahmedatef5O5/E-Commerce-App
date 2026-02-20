import 'package:flutter/material.dart';

import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/utilities/app_images.dart';

class CategoryModel {
  final String id;
  final String name;
  final String imgPath;
  final int productsCount;
  final Color bgColor;
  final Color txtColor;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imgPath,
    required this.productsCount,
    this.bgColor = AppColors.whiteColor,
    this.txtColor = AppColors.blackColor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imgPath': imgPath,
      'productsCount': productsCount,
      'bgColor': bgColor.toARGB32(),
      'txtColor': txtColor.toARGB32(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: (map['id'] as String?) ?? '',
      name: map['name'] as String? ?? '',
      imgPath: map['imgPath'] as String? ?? '',
      productsCount: int.tryParse(map['productsCount'].toString()) ?? 0,
      bgColor: Color(int.tryParse(map['bgColor'].toString()) ?? 0xFFFFFFFF),
      txtColor: Color(int.tryParse(map['txtColor'].toString()) ?? 0xFF000000),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'Accessories',
    imgPath: AppImages.accessories,
    productsCount: 208,
  ),
  CategoryModel(
    id: '2',
    name: 'Collections',
    imgPath: AppImages.collection,
    productsCount: 358,
  ),
  CategoryModel(
    id: '3',
    name: 'Clothes',
    imgPath: AppImages.clothes,
    productsCount: 160,
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    imgPath: AppImages.shoes,
    productsCount: 230,
  ),
];
