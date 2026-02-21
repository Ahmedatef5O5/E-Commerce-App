import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/Home_cubit/home_cubit.dart';
import '../utilities/app_colors.dart';
import 'animated_favorite_icon.dart';

class FavoriteItemWidget extends StatelessWidget {
  final dynamic product;
  final bool isFavorite;

  const FavoriteItemWidget({
    super.key,
    required this.product,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(product.id),
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 100),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value)),
            child: child,
          ),
        );
      },
      child: Dismissible(
        key: Key(product.id),
        direction: DismissDirection.endToStart,
        resizeDuration: const Duration(milliseconds: 150),
        onDismissed: (_) => context.read<HomeCubit>().setFavorite(product),
        background: _buildDeleteBackground(),
        child: _buildProductCard(context),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.delete, color: Colors.redAccent[700], size: 28),
          const Gap(4),
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.redAccent[700],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 10),
        child: Card(
          elevation: 0,
          color: AppColors.whiteColor,
          child: Row(
            children: [
              _buildProductImage(),
              const Gap(12),
              _buildProductInfo(context),
              _buildDeleteButton(context),
              const Gap(12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        Container(
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
                fit: BoxFit.contain,
                placeholder: (_, __) =>
                    const CupertinoActivityIndicator(color: Colors.black12),
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
              isFavorite: isFavorite,
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
            Text(
              product.category,
              style: const TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "\$${product.price}",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.red[100],
      child: IconButton(
        onPressed: () => context.read<HomeCubit>().setFavorite(product),
        icon: Icon(
          CupertinoIcons.delete,
          color: Colors.redAccent[700],
          size: 18,
        ),
      ),
    );
  }
}
