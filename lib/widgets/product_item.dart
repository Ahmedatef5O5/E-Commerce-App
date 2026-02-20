import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../models/product_item_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productItem});
  final ProductItemModel productItem;
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
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
              top: 6,
              right: 6,
              child: Opacity(
                opacity: 0.9,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.blueGrey[200],
                  child: BlocBuilder<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    builder: (context, state) {
                      if (state is! HomeSuccessLoaded) {
                        return SizedBox.shrink();
                      }
                      final isFavorite = state.favoriteProductIds.contains(
                        productItem.id,
                      );
                      final isLoading =
                          state.loadingFavoriteId == productItem.id;
                      if (isLoading) {
                        return const CupertinoActivityIndicator(
                          color: Colors.white,
                        );
                      }
                      return GestureDetector(
                        onTap: () async =>
                            await homeCubit.setFavorite(productItem),
                        child: isFavorite
                            ? Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.redAccent.shade700,
                                // color: Color(0xff880808),
                                size: 24,
                              )
                            : Icon(
                                CupertinoIcons.heart,
                                color: Colors.white,
                                size: 24,
                              ),
                      );
                    },
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
