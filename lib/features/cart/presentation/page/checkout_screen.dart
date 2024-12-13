import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_style.dart';
import 'package:bookia_app/features/cart/data/models/request/place_order_params.dart';
import 'package:bookia_app/features/cart/data/models/response/governorates_data.dart';
import 'package:bookia_app/features/cart/presentation/page/success_screen.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/validation.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/bloc/home_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.total});

  final String total;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var addressController = TextEditingController();

  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int? governorateId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is PlaceOrderLoadedState) {
          pushAndRemoveUntil(context, const SuccessScreen());
        } else if (state is HomeErrorState) {
          Navigator.pop(context);
          showAppDialog(context, state.message, DialogType.error);
        } else if (state is PlaceOrderLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "CheckOut",
            style: getFont24TextStyle(context),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon:  Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).colorScheme.onSurface,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(20),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: "Full Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }else if (!emailValidation(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const Gap(20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                    controller: addressController,
                    decoration: const InputDecoration(hintText: "Address"),
                  ),
                  const Gap(20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                    controller: phoneController,
                    decoration: const InputDecoration(hintText: "Phone"),
                  ),
                  const Gap(20),
                  DropdownMenu(
                      enableSearch: true,
                      expandedInsets: const EdgeInsets.all(0),
                      hintText: "Governorate",
                      onSelected: (value) {
                        governorateId = value;
                      },
                      menuStyle:  MenuStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Theme.of(context).colorScheme.onSecondary,)),
                      inputDecorationTheme: InputDecorationTheme(
                          hintStyle: getFont16TextStyle(context,
                              color: AppColors.greyColor),
                          fillColor: Theme.of(context).colorScheme.onSecondary,
                          filled: true),
                      dropdownMenuEntries: governorateData.map((m) {
                        return DropdownMenuEntry(
                            label: m["governorate_name_en"], value: m['id']);
                      }).toList())
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Total :',
                      style: getFont18TextStyle(context),
                    ),
                    const Spacer(),
                    Text(
                      "${widget.total}\$",
                      style: getFont20TextStyle(context),
                    )
                  ],
                ),
                const Gap(15),
                CustomElevatedButton(
                    text: "CheckOut",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<HomeBloc>().add(PlaceOrderEvent(
                            params: PlaceOrderParams(
                                name: nameController.text,
                                email: emailController.text,
                                address: addressController.text,
                                phone: phoneController.text,
                                governorateId: governorateId)));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
