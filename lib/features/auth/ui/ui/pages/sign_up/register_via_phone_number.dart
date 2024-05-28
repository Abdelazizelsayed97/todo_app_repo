import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_task_todo_listapp/core/button_widget/button_wiget.dart';
import 'package:second_task_todo_listapp/core/regex/app_regex.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';

import '../../../../../../core/helper/spacing.dart';
import '../../../cubit/auth_cubit.dart';
import 'verify_phone_number_page.dart';
import 'widgets/phone_text_field.dart';

class RegisterViaPhoneNumber extends StatefulWidget {
  const RegisterViaPhoneNumber({super.key});

  @override
  State<RegisterViaPhoneNumber> createState() => _RegisterViaPhoneNumberState();
}

class _RegisterViaPhoneNumberState extends State<RegisterViaPhoneNumber> {
  final _phoneNumberController = TextEditingController();
  bool isLoading = false;

  void _handelPress(String phoneNumber) async {
    context.read<AuthCubit>().registerViaPhone('+20$phoneNumber');
  }

  bool _isFilled() {
    return _phoneNumberController.text.length == 10;
  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Register by phone",
          style: Styles.bold(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SafeArea(
          child: Column(
            children: [
              verticalSpace(30),
              Image.asset(
                'lib/assets/images/pngwing.png',
                scale: 2,
              ),
              verticalSpace(50),
              PhoneTextField(
                onChanged: (phone) {
                  _isFilled();
                  setState(() {});
                },
                controller: _phoneNumberController,
              ),
              verticalSpace(30),
              BlocListener<AuthCubit, AuthState>(
                listenWhen: (previous, current) {
                  return current != previous;
                },
                listener: (context, state) {
                  if (state is PhoneNumberSubmitted) {
                    print('PhoneNumberSubmitted state detected');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyPhoneNumberPage(),
                      ),
                    );
                  } else if (state is ErrorOccurred) {
                    Fluttertoast.showToast(
                      msg: state.message,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return AppButton(
                          color: _isFilled()
                              ? Colors.transparent
                              : Colors.grey.shade400,
                          child: const Text("Register"),
                          onPress: AppRegex.isPhoneValid(
                                      "+20${_phoneNumberController.text}") ==
                                  true
                              ? () {
                                  if (!_isFilled()) {
                                    Fluttertoast.showToast(
                                      msg: "Please enter a valid phone number",
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                  _handelPress(_phoneNumberController.text);
                                }
                              : () {
                                  Fluttertoast.showToast(
                                    msg: "Please enter a valid phone number",
                                    backgroundColor: Colors.red,
                                  );
                                });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
