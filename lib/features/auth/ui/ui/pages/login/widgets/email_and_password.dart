import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/app_text_field/app_text_field.dart';

import '../../../../../../../core/helper/spacing.dart';
import '../../../../../../../core/regex/app_regex.dart';

class EmailAndPasswordForm extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController password;
  final void Function(String)? onChanged;

  const EmailAndPasswordForm({
    super.key,
    required this.email,
    required this.password, this.onChanged,
  });

  @override
  State<EmailAndPasswordForm> createState() => _EmailAndPasswordFormState();
}

class _EmailAndPasswordFormState extends State<EmailAndPasswordForm> {
  final formKey = GlobalKey<FormState>();
  bool opsCureText = true;

  late TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        AppTextField(
          onChanged: widget.onChanged,
          label: "Email",
          controller: widget.email,
          textHint: 'Email* ',
          icon: const Icon(Icons.mail_outline),

          validator: (value) {
            if (
                AppRegex.isEmailValid(value!)==false) {
              return "Enter a valid Email";

            }

            print('######${value}');
          },
        ),
        verticalSpace(20.h),
        AppTextField(
          onChanged:widget.onChanged,
          label:"Password",
          maxLines: 1,
          opsCureText: opsCureText,
          textHint: 'Password* ',
          icon: const Icon(Icons.lock_outline),
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  opsCureText = !opsCureText;
                });
              },
              child: Icon(
                opsCureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              )),
          controller: widget.password,
          validator: (value) {
          print('######${value}');
            if (value == null || value.isEmpty) {
              return " Wrong Password ";
            }
          },
        ),
      ],
    ));
  }
}
