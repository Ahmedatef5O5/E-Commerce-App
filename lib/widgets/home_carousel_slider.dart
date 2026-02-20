import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';

class HomeCarouselSlider extends StatelessWidget {
  const HomeCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            child: Center(
              child: CupertinoActivityIndicator(color: Colors.black12),
            ),
          );
        } else if (state is HomeSuccessLoaded) {
          return Column(
            children: [
              FlutterCarousel.builder(
                itemCount: state.homeCarouselSlideItem.length,
                itemBuilder: ((context, index, pageViewIndex) => Container(
                  padding: EdgeInsets.zero,
                  // margin: EdgeInsetsDirectional.only(end: 4, start: 4),
                  width: 365,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),

                    // child: Image.asset(
                    //   state.homeCarouselSlideItem[index].imgPath,
                    //   fit: BoxFit.cover,
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: state.homeCarouselSlideItem[index].imgPath,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                )),
                options: FlutterCarouselOptions(
                  height: 150,
                  viewportFraction: 0.9,
                  autoPlayCurve: Curves.linear,
                  // autoPlay: true,
                  indicatorMargin: 12,
                  // slideIndicator: CircularWaveSlideIndicator(),
                  showIndicator: false,
                  enlargeCenterPage: true,
                  onPageChanged: (intPage, reason) {
                    context.read<HomeCubit>().changeCarouselIndex(intPage);
                  },
                  // onPageChanged: (index, reason) => BlocProvider.of<HomeCubit>(
                  //   context,
                  // ).changeCarouselIndex(index), /// another solution

                  // enlargeCenterPage: true,
                ),
              ),
              Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(state.homeCarouselSlideItem.length, (
                  index,
                ) {
                  final isActive = index == state.currentCarouselIndex;
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                    ),
                  );
                }),
              ),
            ],
          );
        } else if (state is HomeFailureLoaded) {
          return Center(child: Text(state.message));
        } else {
          return SizedBox.shrink(); // nothing
        }
      },
    );
  }
}
