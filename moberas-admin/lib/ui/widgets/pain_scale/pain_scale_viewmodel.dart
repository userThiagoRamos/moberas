import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PainScaleViewModel extends BaseViewModel {
  double lowerValue = 0.0;
  double upperValue = 10.0;
  Color _scaleColor;
  String scaleImg = 'assets/images/scale/well_being/1_verywell.png';

  void setValues(double lower, double upper) {
    lowerValue = lower;
    upperValue = upper;
    notifyListeners();
  }

  Color get scaleColor => _scaleColor;

  void defineColor(double lower, double upper) {
    Color color;
    if (lower > 0.0 && lower <= 2.0) {
      color = Color.fromARGB(255, 60, 98, 171);
      scaleImg = 'assets/images/scale/well_being/1_verywell.png';
    } else if (lower > 2.1 && lower <= 4.0) {
      color = Color.fromARGB(255, 39, 145, 37);
      scaleImg = 'assets/images/scale/well_being/2_good.png';
    } else if (lower > 4.1 && lower <= 7.5) {
      color = Colors.orangeAccent[200];
      scaleImg = 'assets/images/scale/well_being/3_moreorless.png';
    } else if (lower > 7.6 && lower <= 8.7) {
      color = Color.fromARGB(255, 245, 171, 43);
      scaleImg = 'assets/images/scale/well_being/4_bad.png';
    } else if (lower > 8.8) {
      color = Colors.red;
      scaleImg = 'assets/images/scale/well_being/5_verybad.png';
    }

    _scaleColor = color;
    lowerValue = lower;
    upperValue = upper;
    notifyListeners();
  }
}
