import 'package:ecommerce_app/models/carousel_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterCarousel.builder(
          itemCount: 3,
          itemBuilder: ((context, index, pageViewIndex) => Container(
            padding: EdgeInsets.zero,
            // margin: EdgeInsetsDirectional.only(end: 4, start: 4),
            width: 365,
            decoration: BoxDecoration(
              // color: Colors.amber,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                homeCarouselSlideItem[index].imgPath,
                fit: BoxFit.cover,
              ),

              // CachedNetworkImage(
              //   imageUrl: homeCarouselSlideItem[index].imgPath,
              //   fit: BoxFit.cover,
              //   placeholder: (context, url) =>
              //       const Center(child: CircularProgressIndicator.adaptive()),
              // ),
            ),
          )),
          options: FlutterCarouselOptions(
            height: 150,
            viewportFraction: 0.9,
            autoPlayCurve: Curves.linear,
            // autoPlay: true,
            indicatorMargin: 12,
            slideIndicator: CircularWaveSlideIndicator(),
            showIndicator: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(() {
              _currentIndex = index;
            }),
            // enlargeCenterPage: true,
          ),
        ),
        Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(homeCarouselSlideItem.length, (index) {
            final isActive = index == _currentIndex;
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
  }
}
