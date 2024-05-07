import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/text_styles/text_styles.dart';

class TusksPage extends StatefulWidget {
  const TusksPage({super.key});

  @override
  State<TusksPage> createState() => _TusksPageState();
}

class _TusksPageState extends State<TusksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0.r),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome !',
                  style: Styles.bold(
                    fontSize: 32.sp,
                    color: Colors.black,
                  ),
                ),
                // const StatusWidget(),
                // verticalSpace(20),
                // const EventsWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
