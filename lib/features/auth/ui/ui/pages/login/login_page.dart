import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/auth/ui/ui/pages/login/widgets/email_and_password.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/main_tasks_page.dart';

import '../../../../../../core/button_widget/button_wiget.dart';
import '../../../../../../core/helper/spacing.dart';
import '../../../../domain/entity/login_input.dart';
import '../../../cubit/auth_cubit.dart';
import '../sign_up/widgets/custom_register_way_row.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  bool _isFilled() {
    if (emailController.text.isNotEmpty && passWordController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainTasksPage()));
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(state.message),
          ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      filterQuality: FilterQuality.high,
                      alignment: Alignment.center,
                      scale: 3,
                      'lib/assets/images/pngwing.png'),
                  verticalSpace(20),
                  EmailAndPasswordForm(
                    onChanged: (p0) {
                      _isFilled();
                      setState(() {});
                    },
                    email: emailController,
                    password: passWordController,
                  ),
                  verticalSpace(40),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AppButton(
                        color: _isFilled()
                            ? Colors.transparent
                            : Colors.grey.withOpacity(.7),
                        child: (state is LoginLoading)
                            ? const CircularProgressIndicator()
                            : const Text('Login'),
                        onPress: () {
                          _login(
                              input: LoginInput(
                                  email: emailController.text,
                                  password: passWordController.text));
                        },
                      );
                    },
                  ),
                  verticalSpace(100),
                  RegisterWayRow(
                    text1:
                        "Don't have Account ?! Register via one of the following ways:-",
                    style1: Styles.normal(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login({required LoginInput input}) async {
    await context.read<AuthCubit>().login(input: input);
  }
}
