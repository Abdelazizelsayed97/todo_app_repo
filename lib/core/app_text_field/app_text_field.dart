import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.textHint,
    this.icon,
    this.opsCureText,
    this.suffixIcon,
    required this.controller,
    this.validator,
    this.label,
    this.onChanged,
    this.maxLines,
  });

  final TextEditingController controller;
  final String? label;
  final String? textHint;
  final Widget? icon;
  final bool? opsCureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _showError = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (widget.validator != null) {
          final validationError = widget.validator!(value);
          if (_focusNode.hasFocus) {
            _showError = validationError != null;

          }
          return validationError;
        }
        return null;
      },
      onChanged: widget.onChanged,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: widget.opsCureText ?? false,
      maxLines: widget.maxLines,
      inputFormatters: [NoLeadingSpaceFormatter()],
      focusNode: _focusNode,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.r),
        ),
        label: Text(widget.label ?? ''),
        suffixIcon: widget.suffixIcon,
        fillColor: Colors.white,
        filled: true,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: _showError ? Colors.red : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        hintText: widget.textHint,
        prefixIcon: widget.icon,
        contentPadding: const EdgeInsetsDirectional.all(15),
        hintStyle: TextStyle(
          color: const Color(0x600B1A51),
          fontSize: 14.sp,
          fontFamily: 'Somar Sans',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        prefixIconColor: const Color(0xff4051ad29),
      ),
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}
