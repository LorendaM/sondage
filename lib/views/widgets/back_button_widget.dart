// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import '../../utils/constant.dart';


class CustomElevatedButtonBack extends StatelessWidget {

  final Widget child;
  final Icon icon;
  final Function()? onPressed;
  const CustomElevatedButtonBack({
    Key? key,
    required this.onPressed,
    required this.child,required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 130,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: icon
              ),
              const SizedBox(
                width: 10,
              ),
              child,
            ]),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Helper.kPrimaryColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                  color:Helper.kPrimaryColor,
                )
            ),
            ),
            elevation: MaterialStateProperty.all(0)
        ),
      ),
    );
  }
}
