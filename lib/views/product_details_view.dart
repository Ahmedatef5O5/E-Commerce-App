import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/cubit/Product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/widgets/animated_favorite_icon.dart';
import 'package:ecommerce_app/widgets/custom_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Home_cubit/home_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      // buildWhen: (previous, current) =>current is! QuantityCounterLoaded && current is! SelectedSizeState && current is! ProductAddedToCart,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsSuccessLoaded ||
          current is ProductDetailsFailureLoaded,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CupertinoActivityIndicator(color: Colors.black12),
                ),
              ],
            ),
          );
        } else if (state is ProductDetailsSuccessLoaded) {
          return Scaffold(
            backgroundColor: Color(0xffe8e1e9),
            appBar: AppBar(
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(CupertinoIcons.back, size: 28),
              ),
              actionsPadding: EdgeInsets.symmetric(horizontal: 16),
              backgroundColor: Color(0xffe8e1e9),
              elevation: 0,
              scrolledUnderElevation: 0,
              shadowColor: Colors.transparent,
              title: Text('Product Details', style: TextStyle(fontSize: 20)),
              centerTitle: true,

              actions: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, homeState) {
                    if (homeState is! HomeSuccessLoaded) {
                      return const SizedBox.shrink();
                    }
                    final isFavorite = homeState.favoriteProductIds.contains(
                      productId,
                    );
                    return CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blueGrey[100],
                      child: AnimatedFavoriteIcon(
                        isFavorite: isFavorite,
                        onTap: () {
                          final productDetailsState = context
                              .read<ProductDetailsCubit>()
                              .state;
                          if (productDetailsState
                              is ProductDetailsSuccessLoaded) {
                            context.read<HomeCubit>().setFavorite(
                              productDetailsState.product,
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            body: Stack(
              children: [
                Align(
                  alignment: AlignmentGeometry.topCenter,
                  child: CachedNetworkImage(
                    imageUrl: state.product.imgUrl,
                    height: 240,
                    width: 200,
                    placeholder: (context, url) => const Center(
                      // child: CircularProgressIndicator.adaptive(),
                      child: CupertinoActivityIndicator(color: Colors.black12),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: CustomBottomSheet(
                      productName: state.product.name,
                      averegeRate: state.product.averageRate.toString(),
                      quantity: 1, // initial Quantity
                      productId: state.product.id,
                      productDescription: state.product.description,
                      price: state.product.price,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProductDetailsFailureLoaded) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: Text(state.message))],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
