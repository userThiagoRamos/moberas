import 'package:flutter/material.dart';
import 'package:mobEras/ui/widgets/msg_display/msg_display_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MsgDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MsgDisplayViewModel>.reactive(
        viewModelBuilder: () => MsgDisplayViewModel(),
        onModelReady: (model) => model.setMaxValues(
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width),
        builder: (context, model, child) => Visibility(
              visible: model.displayMsgs(),
              child: Row(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceOut,
                    color: Colors.red,
                    height: model.altura,
                    width: model.largura,
                    child: FlatButton(
                      child: Text('${model.info}'),
                      onPressed: () {
                        model.aumentaLargura();
                      },
                    ),
                  )
                ],
              ),
            ));
  }
}
