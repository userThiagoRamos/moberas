import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mobEras/core/utils/moberas_helpers_methods.dart';
import 'package:mobEras/ui/widgets/msg_panel/msg_panel_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MsgPanelWidget extends StatelessWidget {
  final MobErasMessageType msgType;

  const MsgPanelWidget({@required this.msgType});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MsgPanelViewModel>.reactive(
        builder: (context, model, child) =>
            model.dataReady(enumToString(msgType))
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 18.0, 0.0, 1.0),
                      child: Marquee(
                        text: model.dataMap[enumToString(msgType)]
                            .toString()
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.headline2,
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 100.0,
                        pauseAfterRound: Duration(seconds: 3),
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.1,
                        fadingEdgeEndFraction: 0.1,
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
        viewModelBuilder: () => MsgPanelViewModel());
  }
}
