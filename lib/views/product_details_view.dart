import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/cubit/Product_details_cubit/product_details_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: BlocProvider.of<ProductDetailsCubit>(context),
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
            appBar: AppBar(),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: state.product.imgUrl,
                    placeholder: (context, url) => const Center(
                      // child: CircularProgressIndicator.adaptive(),
                      child: CupertinoActivityIndicator(color: Colors.black12),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: const Icon(Icons.error, color: Colors.red),
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
