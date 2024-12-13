import 'package:bookia_app/core/constants/app_icons.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_style.dart';
import 'package:bookia_app/core/widgets/custom_elevated_button.dart';
import 'package:bookia_app/features/auth/presentation/page/register_screen.dart';
import 'package:bookia_app/features/auth/presentation/widgets/or_divider.dart';
import 'package:bookia_app/features/auth/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/dialogs.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/functions/validation.dart';
import '../../../../core/widgets/nav_bar_widget.dart';
import '../../data/model/request/user_model_params.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:  Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.onSurface,
            )),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthLoginSuccessState) {
            pushAndRemoveUntil(context, const NavBarWidget());
            showAppDialog(context,"Login successfully", DialogType.success);
          } else if (state is AuthErrorState) {
            Navigator.pop(context);
            showAppDialog(context, state.message, DialogType.error);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Welcome back! Glad to see you, Again!",
                    style: getFont30TextStyle(context),
                  ),
                  const Gap(32),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      } else if (!emailValidation(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(hintText: "Enter your email"),
                  ),
                  const Gap(15),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your password",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: SvgPicture.asset(
                            AppIcons.eyeSvg,
                          ),
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 17, maxWidth: 80)),
                  ),
                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            pushTo(context, const ForgotPasswordScreen());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: getFont14TextStyle(context,
                                color: AppColors.darkGreyColor),
                          ))
                    ],
                  ),
                   */
                  const Gap(30),
                  CustomElevatedButton(
                      text: "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<AuthBloc>()
                              .add(LoginEvent(UserModelParams(
                                email: emailController.text,
                                password: passwordController.text,
                              )));
                        }
                      }),
                  const Gap(30),
                  const OrDivider(),
                  const Gap(20),
                  const SocialLogin(),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: getFont16TextStyle(context,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      TextButton(
                          onPressed: () {
                            pushWithReplacement(
                                context, const RegisterScreen());
                          },
                          child: Text(
                            "Sign Up",
                            style: getFont16TextStyle(context,
                                color: AppColors.primaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
