import 'dart:developer';

import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/functions/validation.dart';
import 'package:bookia_app/core/widgets/nav_bar_widget.dart';
import 'package:bookia_app/features/auth/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/model/request/user_model_params.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
          if (state is AuthRegisterLoadingState) {
            log("==================================1=========================================");
            showLoadingDialog(context);
          } else if (state is AuthRegisterSuccessState) {
            log("===================================2========================================");
            pushAndRemoveUntil(context, const NavBarWidget());
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
                    'Hello! Register to get started',
                    style: getFont30TextStyle(context),
                  ),
                  const Gap(32),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (!emailValidation(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 17, maxWidth: 53),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: SvgPicture.asset(AppIcons.eyeSvg),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: 'Confirm password',
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 17, maxWidth: 53),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: SvgPicture.asset(AppIcons.eyeSvg),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      } else if (value.length < 8) {
                        return 'Confirm Password must be at least 8 characters';
                      } else if (passwordController.text != value) {
                        return 'Password and Confirm Password must be same';
                      }
                      return null;
                    },
                  ),
                  const Gap(30),
                  CustomElevatedButton(
                    text: 'Register',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(RegisterEvent(UserModelParams(
                              email: emailController.text,
                              name: usernameController.text,
                              password: passwordController.text,
                              passwordConfirmation:
                                  confirmPasswordController.text,
                            )));
                      }
                    },
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: getFont16TextStyle(context,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      TextButton(
                          onPressed: () {
                            pushWithReplacement(context, const LoginScreen());
                          },
                          child: Text(
                            'Sign in',
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
