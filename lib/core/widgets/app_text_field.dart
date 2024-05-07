import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
        this.textHint,
        this.icon,
        this.opsCureText,
        this.suffixIcon,
        required this.controller,
        required this.validator,
        this.label,
        this.onChanged});

  final TextEditingController controller;
  final String? label;
  final String? textHint;
  final Widget? icon;
  final bool? opsCureText;
  final Widget? suffixIcon;
  final Function(String?) validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
    onChanged: onChanged,
    maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
    autofocus: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      return validator(value);
    },
    controller: controller,
    obscureText: opsCureText ?? false,
    decoration: InputDecoration(
        label: Text(label ?? ''),
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        filled: true,
        enabled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.blue)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        hintText: textHint,
        prefixIcon: icon,
        contentPadding: const EdgeInsetsDirectional.all(15),
        hintStyle: const TextStyle(
          color: Color(0x600B1A51),
          fontSize: 14,
          fontFamily: 'Somar Sans',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        prefixIconColor: const Color(0xff4051ad29)),
  );
}
