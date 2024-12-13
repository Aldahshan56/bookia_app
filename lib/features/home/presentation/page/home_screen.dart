import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/service/local/app_local_storage.dart';
import 'package:bookia_app/features/home/presentation/widgets/banner_widget.dart';
import 'package:bookia_app/features/home/presentation/widgets/popular_books_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();

    isDarkMode = AppLocalStorage.getData(AppLocalStorage.isDarkModeKey) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Theme.of(context).colorScheme.onTertiary,
          child: SvgPicture.asset(
            AppImages.appLogoSvg,
            height: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()async {
              setState(() {
                isDarkMode = !isDarkMode;
              });
              await AppLocalStorage.setDarkMode(isDarkMode);
              AppLocalStorage.isDarkModeNotifier.value = isDarkMode;
            },
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode?Colors.white:Colors.black,
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Gap(20), BannerWidget(), Gap(10), PopularBooksList()],
        ),
      ),
    );
  }
}
