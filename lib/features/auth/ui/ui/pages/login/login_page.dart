import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/main_tasks_page.dart';

import '../../../../../../core/button_widget/button_wiget.dart';
import '../../../../../../core/helper/spacing.dart';
import '../../../../../../core/widgets/app_text_field.dart';
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
            content: Text(state.message),
          ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    filterQuality: FilterQuality.high,
                    alignment: Alignment.center,
                    scale: 3,
                    'lib/assets/images/pngwing.com.png'),
                verticalSpace(20),
                AppTextField(
                  label: 'email',
                  controller: emailController,
                ),
                verticalSpace(20),
                AppTextField(
                  label: 'password',
                  controller: passWordController,
                ),
                verticalSpace(40),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    Future.delayed(const Duration(seconds: 3));
                    return AppButton(
                      color: Colors.transparent,
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
    );
  }

  Future<void> _login({required LoginInput input}) async {
    await context.read<AuthCubit>().login(input: input);
  }
}
