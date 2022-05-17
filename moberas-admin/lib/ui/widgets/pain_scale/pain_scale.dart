import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mobEras/ui/widgets/pain_scale/pain_scale_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PainScale extends StatelessWidget {
  final Function(double) selectedCallback;

  const PainScale({Key key, this.selectedCallback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PainScaleViewModel>.reactive(
        viewModelBuilder: () => PainScaleViewModel(),
        builder: (context, model, child) => Column(
              children: <Widget>[
                // buildPainScaleImg(),
                Expanded(flex: 3, child: buildPainScaleSlider(model, context)),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    hoverElevation: 2,
                    onPressed: () => selectedCallback(model.lowerValue),
                    child: Text('Clique para confirmar sua escolha: ${model.lowerValue.toInt()}', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)),
                  ),
                )
              ],
            ));
  }

  Widget buildPainScaleSlider(PainScaleViewModel model, BuildContext context) {
    return FlutterSlider(
      selectByTap: true,
      handlerHeight: 60,
      axis: Axis.vertical,
      values: [model.lowerValue, model.upperValue],
      max: 10.0,
      min: 0.0,
      touchSize: 10,
      visibleTouchArea: false,
      jump: true,
      maximumDistance: 1,
      step: FlutterSliderStep(step: 1.0),
      tooltip: FlutterSliderTooltip(
        alwaysShowTooltip: true,
        textStyle: TextStyle(fontSize: 17, color: Colors.white),
        direction: FlutterSliderTooltipDirection.right,
        format: (value) => value.replaceAll('.0', ''),
        boxStyle: FlutterSliderTooltipBox(
          decoration: BoxDecoration(
            color: model.scaleColor,
          ),
        ),
      ),
      trackBar: FlutterSliderTrackBar(
        activeTrackBarHeight: 150,
        inactiveTrackBarHeight: 150,
        inactiveTrackBar: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(image: AssetImage('assets/images/scale/pain/zerototen.png'), fit: BoxFit.fitHeight),
        ),
        activeTrackBar: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      onDragging: (index, lower, upper) => model.defineColor(lower, upper),
      handler: FlutterSliderHandler(
        child: Image.asset(
          model.scaleImg,
        ),
      ),
    );
  }

  Widget buildPainScaleImg() {
    return Builder(
      builder: (context) => Image.asset(
        'assets/images/scale/pain/zerototen.png',
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
