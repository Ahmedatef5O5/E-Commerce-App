import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:flutter/material.dart';

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
