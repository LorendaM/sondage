import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  final Color color;
  final Widget child;
  final Widget icon;
  final double? width;
  final Function()? onPressed;
  const FloatingButtonWidget({
    required this.color,
    required this.onPressed,
    required this.child, this.width, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: width ?? 110,
      child: FloatingActionButton.extended(
        heroTag: null,
          onPressed: onPressed,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8),
        ),
        ),
          backgroundColor: color,
        label: child,
        icon: icon,
      ),
    );
  }
}
