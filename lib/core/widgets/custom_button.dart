import 'package:flutter/material.dart';
import 'package:tesk/core/utils/app_styles.dart';
import 'package:tesk/core/utils/methods.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    this.onPressed,
  });

  final Color color;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppStyles.styleMedium16.copyWith(
            color: Colors.white,
            fontSize: getResponsiveFontSize(context, fontSize: 16)),
      ),
    );
  }
}
