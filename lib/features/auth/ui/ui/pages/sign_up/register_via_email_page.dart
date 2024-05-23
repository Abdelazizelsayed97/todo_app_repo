import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/main_tasks_page.dart';

import '../../../../../../core/app_text_field/app_text_field.dart';
import '../../../../../../core/button_widget/button_wiget.dart';
import '../../../../../../core/helper/spacing.dart';
import '../../../../domain/entity/login_input.dart';
import '../../../cubit/auth_cubit.dart';

class RegisterViaEmailPage extends StatefulWidget {
  const RegisterViaEmailPage({super.key});

  const RegisterViaEmailPage._();

  @override
  State<RegisterViaEmailPage> createState() => _RegisterViaEmailPageState();
}

class _RegisterViaEmailPageState extends State<RegisterViaEmailPage> {
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();

  final valueState = WidgetStatesController();
  final ValueNotifier<bool> _isValueNotifier = ValueNotifier(false);

  bool _isFilled() {
    if ((_emailController.text.isNotEmpty &&
        _passWordController.text.isNotEmpty)) {
      _isValueNotifier.value = true;
    } else {
      _isValueNotifier.value = false;
    }
    return _isValueNotifier.value;
  }

  @override
  void initState() {
    _isFilled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainTasksPage()));
        }
        if (state is RegisterFailure) {
          Fluttertoast.showToast(
              msg: state.message, backgroundColor: Colors.red);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    filterQuality: FilterQuality.high,
                    alignment: Alignment.bottomCenter,
                    scale: 3,
                    'lib/assets/images/pngwing.com.png'),
                verticalSpace(30),
                AppTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  onChanged: (p0) {
                    _isFilled();
                    setState(() {});
                  },
                ),
                verticalSpace(20),
                AppTextField(
                  onChanged: (p0) {
                    _isFilled();
                    setState(() {});
                  },
                  controller: _passWordController,
                  label: 'Password',
                ),
                verticalSpace(20),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AppButton(
                      onPress: () {
                        _onPressed();
                      },
                      color: _isFilled() ? Colors.transparent : Colors.grey,
                      child: (state is RegisterLoading)
                          ? const CircularProgressIndicator()
                          : const Text("Register"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    if (_isFilled()) {
      context.read<AuthCubit>().registerViaEmail(LoginInput(
          email: _emailController.text, password: _passWordController.text));
    }
  }
}
