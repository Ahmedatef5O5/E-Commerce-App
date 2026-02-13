import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.whiteColor,

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          'Location',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 19,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8),
            Text(
              'Choose your location',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 21,
                color: AppColors.blackColor,
              ),
            ),
            Gap(12),
            Text(
              'Let\'s find your unforgettable event.Choose a location below to get started.',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black38,
              ),
            ),
            Gap(20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
