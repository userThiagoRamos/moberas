import 'package:flutter/material.dart';
import 'package:mobEras/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      onModelReady: (model) => model.handleStartUpLogic(),
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, model, child) => Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
