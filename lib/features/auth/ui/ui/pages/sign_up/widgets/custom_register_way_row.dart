import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:second_task_todo_listapp/core/helper/spacing.dart';
import 'package:second_task_todo_listapp/features/auth/ui/ui/pages/sign_up/register_via_email_page.dart';
import 'package:second_task_todo_listapp/features/auth/ui/ui/pages/sign_up/register_via_phone_number.dart';

class RegisterWayRow extends StatelessWidget {
  const RegisterWayRow({
    super.key,
    required this.text1,
    required this.style1,
  });

  final String text1;
  final TextStyle style1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              text1,
              style: style1,
            ),
          ],
        ),
        verticalSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterViaPhoneNumber()));
                    },
                    child: Image.asset(
                      "lib/assets/images/password-authentication.jpg",
                      scale: 25,
                    )),
                verticalSpace(5),
                const Text('Phone')
              ],
            ),
            horizontalSpace(10),
            const VerticalDivider(),
            horizontalSpace(10),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterViaEmailPage()));
                    },
                    child: SvgPicture.asset(
                      'lib/assets/images/email.svg',
                      height: 50.h,
                    )),
                verticalSpace(5),
                const Text('E-mail'),
              ],
            ),
          ],
        )
      ],
    );
  }
}
