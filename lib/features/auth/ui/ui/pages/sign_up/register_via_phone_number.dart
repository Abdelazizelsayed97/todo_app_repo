import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/button_widget/button_wiget.dart';

import '../../../../../../core/helper/spacing.dart';
import '../../../cubit/auth_cubit.dart';
import 'verify_phone_number_page.dart';
import 'widgets/phone_text_field.dart';

class RegisterViaPhoneNumber extends StatefulWidget {
  RegisterViaPhoneNumber({super.key});

  @override
  State<RegisterViaPhoneNumber> createState() => _RegisterViaPhoneNumberState();
}

class _RegisterViaPhoneNumberState extends State<RegisterViaPhoneNumber> {
  final _phoneNumberController = TextEditingController();

  void _handelPress(String phoneNumber) async {
    context.read<AuthCubit>().registerViaPhone('+20$phoneNumber');
  }

  bool _isFilled() {
    if (_phoneNumberController.text.length == 10) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register by phone",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SafeArea(
          child: Column(
            children: [
              verticalSpace(30),
              Image.asset(
                'lib/assets/images/pngwing.com.png',
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const VerifyPhoneNumberPage()));
                  }
                },
                child: AppButton(
                  color:
                      _isFilled() ? Colors.transparent : Colors.grey.shade400,
                  child: const Text("Register"),
                  onPress: () {
                    _handelPress(_phoneNumberController.text);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
