import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';

class StatusFilterBar extends StatelessWidget {
  final TapsEnumType? currentTapsEnum;
  final void Function(TapsEnumType tap) onChange;

  const StatusFilterBar({
    super.key,
    this.currentTapsEnum = TapsEnumType.All,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: TapsEnumType.values.map((type) {
        final isSelected = currentTapsEnum == type;
        return GestureDetector(
          onTap: () => onChange(type),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(
                          color: Colors.transparent,
                          width: 3.w,
                          strokeAlign: BorderSide.strokeAlignInside,
                          style: BorderStyle.solid)
                      : Border.all(color: Colors.grey),
                  color: isSelected ? Colors.brown : Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                    maxLines: 1,
                    type.toString().split('.').last,
                    style: Styles.bold(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 11.sp)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

enum TapsEnumType {
  All,
  Urgent,
  Complete,
  UnComplete,
}
