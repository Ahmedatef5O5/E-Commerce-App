import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:ecommerce_app/widgets/favorite_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utilities/app_colors.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;
    if (homeState is HomeSuccessLoaded) {
      final favoriteProducts = homeState.productItems
          .where((product) => homeState.favoriteProductIds.contains(product.id))
          .toList();
      if (favoriteProducts.isEmpty) {
        return Center(child: const Text('No favorite products'));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.separated(
          key: ValueKey(favoriteProducts.length),
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteProducts[index];
            return FavoriteItemWidget(
              product: product,
              isFavorite: homeState.favoriteProductIds.contains(product.id),
            );
          },
          separatorBuilder: (context, index) => Divider(
            indent: 20,
            endIndent: 20,
            color: AppColors.greyWithShade,
          ),
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.42,
      child: Center(child: CupertinoActivityIndicator(color: Colors.black12)),
    );
  }
}
