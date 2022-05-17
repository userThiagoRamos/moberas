import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/theme_cfg.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';
import 'package:moberas_dashboard/features/response/model/milestone_response.dart';

abstract class IPacientService {
  Future<List<UserProfile>> listAll();
  Future<List<UserProfile>> findByNameOrCpf(String name, String cpf);
  Future<void> sendMsg(String uid, String msg);
  Future<void> changeTheme(ThemeCfg theme, String uid);
  Future<UserProfile> fetchByUID({@required String uid});
  Future<List<MilestoneResponse>> fetchMilestoneResponseList(String uid);
  Future<List<ActivityResponse>> fetchDynamicResponseList(String uid);
  Stream<List<MilestoneResponse>> streamMilestoneResponseList(String uid);
  Stream<List<ActivityResponse>> streamDynamicResponseList(String uid);
}
