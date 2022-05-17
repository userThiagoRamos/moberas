import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';
import 'package:moberas_dashboard/features/response/service/response_service_interface.dart';

import '../../../locator.dart';

class ResponseListWidget extends StatefulWidget {
  final String uid;

  const ResponseListWidget({Key key, this.uid}) : super(key: key);

  @override
  _ResponseListWidgetState createState() => _ResponseListWidgetState();
}

class _ResponseListWidgetState extends State<ResponseListWidget> {
  final IResponseService _responseService = locator<IResponseService>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ActivityResponse>>(
        stream: _responseService.activityResponse$(uid: widget.uid),
        builder: (context, arStream) => arStream.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    ListTile(title: Text(arStream.data[index].activity)))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
