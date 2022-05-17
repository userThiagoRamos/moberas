import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';

abstract class IResponseService {
  Stream<List<ActivityResponse>> activityResponse$({@required String uid});
}
