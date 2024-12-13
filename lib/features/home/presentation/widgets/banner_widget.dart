import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetSlidersEvent());
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (pervious, current) =>
          current is GetSlidersLoadedState || current is GetSlidersLoadingState,
      builder: (context, state) {
        if (state is GetSlidersLoadedState) {
          var sliderList = context.read<HomeBloc>().sliders;
          return Column(
            children: [
              CarouselSlider.builder(
                  itemCount: sliderList.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        sliderList[itemIndex].image ?? "",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                      height: 180,
                      //aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      })),
              const Gap(10),
              SmoothPageIndicator(
                  controller: PageController(
                      initialPage: currentIndex), // PageController
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.borderColor,
                      dotHeight: 10,
                      dotWidth: 10), // your preferred effect
                  onDotClicked: (index) {})
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
