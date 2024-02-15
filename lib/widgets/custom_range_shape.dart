import 'package:flutter/material.dart';


import '../helpers/theme_helper.dart';

class CustomThumbShape implements RangeSliderThumbShape {

  final double radius;
  final Color ringColor;

  const CustomThumbShape({
    this.radius = 7,
    this.ringColor = Colors.black,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      bool isDiscrete = true,
      bool isEnabled = true,
      bool isOnTop = true,
      TextDirection textDirection = TextDirection.ltr,
      required SliderThemeData sliderTheme,
      Thumb thumb = Thumb.start,
      bool isPressed = true}) {
    // To create a ring create outer circle and create an inner cicrle then
    // subtract inner circle from outer circle and you will get a ring shape
    // fillType = PathFillType.evenOdd will be used for that

    final Canvas canvas = context.canvas;
    Path outerRing = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..fillType = PathFillType.evenOdd;
    Path innerCircle = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius - 2));

    canvas.drawPath(outerRing, Paint()..color = ringColor);
    canvas.drawPath(innerCircle, Paint()..color = Colors.white);
  }
}
