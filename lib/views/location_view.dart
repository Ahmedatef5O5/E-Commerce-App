import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
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
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.blueGrey.shade400,
                        // color: Colors.black38,
                        size: 28,
                      ),
                      hint: Text(
                        'Enter Your Location',
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.blueGrey.shade400,
                              // color: Colors.black38,
                            ),
                      ),
                      suffixIcon: Icon(
                        Icons.share_location_outlined,
                        color: Colors.blueGrey.shade400,
                        // color: Colors.black38,
                        size: 28,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 1.6,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                          color: Colors.blueGrey.shade600,
                          width: 1.6,
                        ),
                      ),
                    ),
                    cursorColor: Colors.blueGrey.shade400,
                  ),
                  Gap(18),
                  Text(
                    'select location',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Gap(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dummyLocations.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyWithShade),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dummyLocations[index].city,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                    ),
                                    Gap(4),
                                    Text(
                                      '${dummyLocations[index].city}, ${dummyLocations[index].countery}',

                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.grey.shade500,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 68,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 4,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: dummyLocations[index].imgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // another solution Nested CircleAvater instead of container(cirlce shape)
                                // CircleAvatar(
                                //   radius: 34,
                                //   backgroundColor: AppColors.primaryColor,
                                //   child: CircleAvatar(
                                //     radius: 30,
                                //     backgroundImage: CachedNetworkImageProvider(
                                //       dummyLocations[index].imgUrl,
                                //       maxWidth: 65,
                                //       maxHeight: 65,
                                //       // fit: BoxFit.contain,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(12),

                  CustomElevatedButton(
                    child: Text('Confirm'),
                    onPressed: () {},
                  ),
                  Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
