import 'package:flutter/material.dart';
import 'package:tesk/core/utils/app_constants.dart';
import 'package:tesk/core/utils/app_styles.dart';
import 'package:tesk/core/utils/methods.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.text,
    this.controller,
    this.suffixIcon,
    this.enabled = false,
    this.enabledContent,
  });

  final Function(String)? onChanged;
  final String? text;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? enabledContent;
  final bool? enabled;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = false;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: AppStyles.styleMedium18.copyWith(
          color: Colors.black,
          fontSize: getResponsiveFontSize(context, fontSize: 18),
          fontWeight: FontWeight.w400,
        ),
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: Colors.black,
        cursorWidth: 1.5,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(
            color: primaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 18),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: secondaryColor,
              width: 1.5,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: _toggleVisibility,
            child: widget.suffixIcon,
          ),
        ));
  }
}
