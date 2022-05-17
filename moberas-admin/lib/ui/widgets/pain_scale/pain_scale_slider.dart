import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSlider extends StatelessWidget {
  final String label;
  final double height;
  final Slider child;

  const CustomSlider({
    @required this.child,
    @required this.label,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
            activeTrackColor: Colors.white,
          ),
          child: child,
        ),
      ],
    );
  }
}
