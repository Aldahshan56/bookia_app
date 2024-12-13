import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/utils/text_style.dart';
import 'package:bookia_app/core/widgets/custom_elevated_button.dart';
import 'package:bookia_app/core/widgets/nav_bar_widget.dart';
import 'package:bookia_app/features/home/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/navigation.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child:  Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                      AppImages.successMarkSvg,
                  width: 150,
                  ),
                  const Gap(15),
                  Text("SUCCESS!",style: getFont24TextStyle(context),),
        
                  const Gap(15),
                  Text("Your order will be delivered soon.Thank you for choosing our app!",
                    style: getFont18TextStyle(context),textAlign: TextAlign.center,),
                  const Gap(30),
                  CustomElevatedButton(text: "Back To Home", onPressed:(){
                    pushAndRemoveUntil(context, const NavBarWidget(preIndex: 0,));
                  })
        
                ],
              ),
            ),
        ),
      ),
    );
  }
}
