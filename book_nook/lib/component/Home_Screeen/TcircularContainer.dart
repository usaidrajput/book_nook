import 'package:flutter/material.dart';

class TcircularContainer extends StatelessWidget {
  const TcircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0.0, // Ensure padding is a valid double value
    this.backgroundColor = Colors.white,
  });

  final double? width;
  final double? height;
  final double? radius;
  final Widget? child;
  final Color backgroundColor;
  final double padding; // Change padding to a non-nullable double

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Use the passed width
      height: height, // Use the passed height
      padding: EdgeInsets.all(
          padding), // Use the passed padding (now always a double)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            radius ?? 400), // Use the passed radius, default to 400
        color:
            backgroundColor.withOpacity(0.1), // Use the passed background color
      ),
      child: child,
    );
  }
}
