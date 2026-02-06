import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product_item_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productItem});
  final ProductItemModel productItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 12,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[500],
              child: Icon(CupertinoIcons.heart, color: Colors.white, size: 24),
            ),
          ),
          Image.network(productItem.imgUrl, height: 100, width: 100),
        ],
      ),
    );
  }
}
