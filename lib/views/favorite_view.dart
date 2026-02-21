import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/cubit/Favorite_cubit/favorite_cubit.dart';
import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:ecommerce_app/widgets/animated_favorite_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../utilities/app_colors.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeState = context.watch<HomeCubit>().state;
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: favoriteCubit,
      buildWhen: (previous, current) =>
          current is FavoriteSuccessLoaded ||
          current is FavoriteLoading ||
          current is FavoriteFailure,
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.42,
            child: Center(
              child: CupertinoActivityIndicator(color: Colors.black12),
            ),
          );
        } else if (state is FavoriteSuccessLoaded) {
          final favoriteProducts = state.favoriteProducts;
          if (favoriteProducts.isEmpty) {
            return Center(child: const Text('No favorite products'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RefreshIndicator(
              onRefresh: () async => await favoriteCubit.getFavoriteProducts(),
              child: ListView.separated(
                // physics: const BouncingScrollPhysics(),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 10),
                    child: Card(
                      elevation: 0,
                      color: AppColors.whiteColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                height: 140,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey5,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: CachedNetworkImage(
                                      imageUrl: product.imgUrl,
                                      height: 180,
                                      width: 150,
                                      fit: BoxFit.contain,
                                      placeholder: (context, url) => const Center(
                                        // child: CircularProgressIndicator.adaptive(),
                                        child: CupertinoActivityIndicator(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.black12,
                                  child: AnimatedFavoriteIcon(
                                    size: 19,
                                    isFavorite: true,
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(12),
                          SizedBox(
                            height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                              children: [
                                Gap(2),
                                Text(
                                  product.name,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17,
                                      ),
                                ),
                                Text(
                                  product.category,
                                  // maxLines: 1,
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(
                                        color: Colors.black26,

                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                ),
                                Gap(2),
                              ],
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.red[100],
                            child: BlocConsumer<FavoriteCubit, FavoriteState>(
                              bloc: favoriteCubit,
                              listenWhen: (previous, current) =>
                                  current is FavoriteFailureRemoved ||
                                  current is FavoriteSuccessRemoved,
                              listener: (context, state) {
                                if (state is FavoriteFailureRemoved) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errMsg),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (state is FavoriteSuccessRemoved) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Successfully removed!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              },
                              buildWhen: (previous, current) =>
                                  current is FavoriteSuccessRemoved ||
                                  current is FavoriteFailureRemoved ||
                                  current is FavoriteRemoving,
                              builder: (context, state) {
                                if (state is FavoriteRemoving) {
                                  Center(
                                    child: CupertinoActivityIndicator(
                                      color: Colors.black12,
                                    ),
                                  );
                                } else if (state is FavoriteSuccessRemoved) {
                                  return IconButton(
                                    onPressed: () async => await favoriteCubit
                                        .removeFavorite(product.id),
                                    icon: Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.redAccent[700],
                                      size: 20,
                                    ),
                                  );
                                }
                                return IconButton(
                                  onPressed: () async => await favoriteCubit
                                      .removeFavorite(product.id),
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.redAccent[700],
                                    size: 20,
                                  ),
                                );
                              },
                            ),
                          ),
                          Gap(12),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  indent: 20,
                  endIndent: 20,
                  color: AppColors.greyWithShade,
                ),
              ),
            ),
          );
        } else if (state is FavoriteFailure) {
          return Center(child: Text(state.errMsg));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
