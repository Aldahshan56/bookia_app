import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/dialogs.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../intro/welcome/welcome_screen.dart';
import '../../data/model/request/edit_user_model_params.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(GetProfileEvent()), // Trigger only GetProfileEvent initially
      child: BlocConsumer<ProfileBloc, ProfileState>(
          // Define buildWhen to only rebuild when necessary
          buildWhen: (previous, current) =>
          current is GetProfileSuccessState ||
              current is GetProfileLoadingState ||
              current is LogOutLoadingState ||
              current is LogOutLoadedState ||
              current is ProfileErrorState,
        listener: (context, state) {
          // Handle logout states
          log("Listener state: $state");
          if (state is LogOutLoadingState) {
            log("Logging out...");
            // Show loading indicator while logging out
            showLoadingDialog(context);
          } else if (state is LogOutLoadedState) {
            log("Logged out successfully");
            // Hide loading indicator and navigate to WelcomeScreen
            Navigator.pop(context); // Close the loading dialog
            pushAndRemoveUntil(context, const WelcomeScreen());
            showAppDialog(context,"Logged out successfully", DialogType.success);
            log('Navigating to WelcomeScreen...');// Navigate to WelcomeScreen
          } else if (state is ProfileErrorState) {
            log("Logout failed");
            // Hide loading indicator if there's an error
            Navigator.pop(context); // Close the loading dialog
            // Show error message
            showAppDialog(context, state.massage, DialogType.error);
          }
        },
          builder: (context, state) {
            if (state is GetProfileSuccessState) {
              var profile = context.read<ProfileBloc>().profileResponse?.data;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Profile'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        log("4444444444444444444444444444444444444444444444444444");
                        context.read<ProfileBloc>().add(LogoutEvent());
                        log("4444444444444444444444444444444444444444444444444444");
                      },
                      icon: Icon(Icons.logout_rounded,color:Theme.of(context).colorScheme.onSurface),
                    ),
                    const Gap(5),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(profile?.image ?? ''),
                            ),
                            const Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile?.name ?? '',
                                    style: getFont16TextStyle(context),
                                  ),
                                  Text(
                                    profile?.email ?? '',
                                    style: getFont16TextStyle(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Divider(
                          color: AppColors.greyColor.withOpacity(.5),
                          endIndent: 20,
                          indent: 20,
                        ),
                        const Gap(10),
                        // Other menu items...
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // تحديد الزوايا المنحنية
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface, // لون الحدود
                              width: 2, // سمك الحدود
                            ),
                          ),
                          color: Theme.of(context).colorScheme.onSecondary,
                          elevation: 20,
                          shadowColor: AppColors.greyColor.withOpacity(.3),
                          child: ListTile(
                            onTap: () {
                              pushTo(
                                context,
                                EditProfileView(
                                  model: EditUserModelParams(
                                    address: profile?.address,
                                    image: profile?.image,
                                    name: profile?.name,
                                    phone: profile?.phone,
                                  ),
                                ),
                              );
                            },
                            tileColor: Theme.of(context).colorScheme.onSecondary,
                            title:  Text('Edit Profile',style: getFont20TextStyle(context),),
                            trailing: Icon(Icons.chevron_right,color: Theme.of(context).colorScheme.onSurface,),
                          ),
                        ),
                        const Gap(5),
                        // Additional cards as needed...
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is GetProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),

    );
  }
}
