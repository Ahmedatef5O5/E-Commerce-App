import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/cubit/Choose_Location_cubit/choose_location_cubit.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChooseLocationCubit>(context);
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
                    controller: locationController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.blueGrey.shade400,
                        // color: Colors.black38,
                        size: 28,
                      ),

                      hintText:
                          'Enter Your Location : City-Country', // as String
                      hintStyle: Theme.of(context).textTheme.labelMedium!
                          .copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.blueGrey.shade400,
                            // color: Colors.black38,
                          ),
                      // as widget hint: Text(
                      //   'Enter Your Location',
                      //   style: Theme.of(context).textTheme.labelMedium!
                      //       .copyWith(
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 16,
                      //         color: Colors.blueGrey.shade400,
                      //         // color: Colors.black38,
                      //       ),
                      // ),
                      suffixIcon:
                          BlocConsumer<
                            ChooseLocationCubit,
                            ChooseLocationState
                          >(
                            bloc: cubit,
                            listenWhen: (previous, current) =>
                                current is AddedLocations ||
                                current is AddingLocationsFailuer,
                            listener: (context, state) {
                              if (state is AddedLocations) {
                                locationController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Location Added!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                              if (state is AddingLocationsFailuer) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      // 'Please Enter valid location! (city-country)',
                                      state.errMsg,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            buildWhen: (previous, current) =>
                                current is AddingLocations ||
                                current is AddedLocations ||
                                current is AddingLocationsFailuer,

                            builder: (context, state) {
                              if (state is AddingLocations) {
                                return Align(
                                  alignment: AlignmentGeometry.center,
                                  child: CupertinoActivityIndicator(
                                    color: Colors.black12,
                                  ),
                                );
                              } else {
                                return IconButton(
                                  onPressed: () {
                                    if (locationController.text.isNotEmpty) {
                                      cubit.addLocation(
                                        locationController.text,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Enter Your Location'),
                                        ),
                                      );
                                    }
                                  },
                                  // Icons.share_location_outlined,
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 28,
                                  ),
                                  color: Colors.blueGrey.shade400,

                                  // color: Colors.black38,
                                );
                              }
                            },
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
                    child: BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                      buildWhen: (previous, current) =>
                          current is FetchLocationsLoading ||
                          current is FetchLocationsSuccessLoaded ||
                          current is FetchLocationsFailure,
                      builder: (context, state) {
                        if (state is FetchLocationsLoading) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.42,
                            child: Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.black12,
                              ),
                            ),
                          );
                        } else if (state is FetchLocationsSuccessLoaded) {
                          final locations =
                              state.locations; // Locations from Cubit
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: locations.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.greyWithShade,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // dummyLocations[index].city,
                                            locations[index].city,
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
                                            '${locations[index].city}, ${locations[index].country}',

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
                                          color: AppColors.greyWithShade,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            //  color: AppColors.greyWithShade, // inactiveColor
                                            color: AppColors
                                                .primaryColor, //  activeColor
                                            width: 4,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                dummyLocations[index].imgUrl,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                                  child:
                                                      CupertinoActivityIndicator(
                                                        color: Colors.black12,
                                                      ),
                                                ),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                  child: const Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
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
                          );
                        } else if (state is FetchLocationsFailure) {
                          return Center(child: Text(state.errMsg));
                        } else {
                          return SizedBox.shrink();
                        }
                      },
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
