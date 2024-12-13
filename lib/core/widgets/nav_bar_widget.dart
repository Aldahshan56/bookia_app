import "package:bookia_app/core/constants/app_icons.dart";
import "package:bookia_app/core/utils/colors.dart";
import "package:bookia_app/features/cart/presentation/page/cart_screen.dart";
import "package:bookia_app/features/home/presentation/page/home_screen.dart";

import "package:bookia_app/features/wishlist/presentation/page/wishlist_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../../features/profile_test/presentation/page/test.dart";

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key,this.preIndex});
 final int? preIndex;
  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    currentPage=widget.preIndex??0;
  }
  List<Widget> pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPage],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.darkColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppIcons.homeSvg,
                    colorFilter:  ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(AppIcons.homeSvg),
                  label: "Home"),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppIcons.bookMarkSvg,
                    colorFilter:  ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(AppIcons.bookMarkSvg),
                  label: "BookMark"),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppIcons.groupSvg,
                    colorFilter:  ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(AppIcons.groupSvg),
                  label: "Group"),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppIcons.profileSvg,
                    colorFilter:  ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(AppIcons.profileSvg),
                  label: "Person"),
            ]));
  }
}
