import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String data;
  final double textSize;
  final FontWeight? fontWeight;
  Color color;
  bool? canNotBeChangeIntoDark;
  final TextAlign? align;
  CustomText(
      {Key? key,
      required this.data,
      required this.color,
      required this.textSize,
      this.fontWeight,
      this.canNotBeChangeIntoDark,
      this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: "futura",
        fontSize: textSize ,
        fontWeight: fontWeight,
        color: canNotBeChangeIntoDark != true
            ? color == Colors.black || color == Colors.black

                ? Colors.white
                : Colors.black
            : color,
      ),
      textAlign: align,
    );
  }
}
