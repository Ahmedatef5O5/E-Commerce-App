import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../models/product_item_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productItem});
  final ProductItemModel productItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.zero,
              height: 180,
              width: 190,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CachedNetworkImage(
                    imageUrl: productItem.imgUrl,
                    height: 180,
                    width: 150,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      // child: CircularProgressIndicator.adaptive(),
                      child: CupertinoActivityIndicator(color: Colors.black12),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 4,
              right: 6,
              child: Opacity(
                opacity: 0.6,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[600],
                  child: Icon(
                    CupertinoIcons.heart,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),

        Gap(2),
        Text(
          productItem.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        Gap(2),
        Text(
          productItem.category,
          // maxLines: 1,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.black26,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(2),
        Text(
          "\$${productItem.price}",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
