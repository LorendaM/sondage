// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import '../../utils/constant.dart';


class CustomElevatedButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final double? width;
  final Color? borderColor;
  final Function()? onPressed;
  const CustomElevatedButton({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.child, this.width, this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                  color: borderColor == null? Helper.kPrimaryColor: borderColor!,
                )
            ),
            ),
            elevation: MaterialStateProperty.all(0)
            ),
      ),
    );
  }
}
