import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/main_tasks_page.dart';

import '../../../../../../core/helper/spacing.dart';
import '../../../cubit/auth_cubit.dart';
import 'widgets/confirm_phone_number.dart';

class VerifyPhoneNumberPage extends StatelessWidget {
  const VerifyPhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is PhoneOTPVerified) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainTasksPage()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Verification",
            style: Styles.bold(fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify your phone number",
                style: Styles.bold(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              verticalSpace(30),
              Text(
                "Enter the received code",
                style: Styles.meduim(fontSize: 16),
              ),
              verticalSpace(50),
              const ConfirmPhoneNumber()
            ],
          ),
        ),
      ),
    );
  }
}
