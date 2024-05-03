import 'package:flutter/material.dart';
import 'package:tesk/core/utils/app_constants.dart';
import 'package:tesk/core/utils/app_styles.dart';
import 'package:tesk/core/utils/methods.dart';

class CustomFilterWidget extends StatefulWidget {
  const CustomFilterWidget(
      {super.key, required this.filterName, this.onTap, required this.colored});

  final String filterName;
  final void Function()? onTap;
  final bool colored;

  @override
  State<CustomFilterWidget> createState() => _CustomFilterWidgetState();
}

class _CustomFilterWidgetState extends State<CustomFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.2,
              color: primaryColor,
            ),
            color: widget.colored == true ? primaryColor : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.filterName,
                style: AppStyles.styleMedium16.copyWith(
                    color: widget.colored == true ? Colors.white : primaryColor,
                    fontSize: getResponsiveFontSize(context, fontSize: 16)),
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: widget.colored == true ? Colors.white : primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
