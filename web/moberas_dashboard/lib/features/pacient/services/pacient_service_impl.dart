import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:moberas_dashboard/database/firestore.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/position.dart';
import 'package:moberas_dashboard/features/pacient/models/theme_cfg.dart';
import 'package:moberas_dashboard/features/response/model/milestone_response.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';

import 'pacient_service_interface.dart';

@LazySingleton(as: IPacientService)
class IPacientServiceImpl extends IPacientService {
  String dynamicResponsePath = '/users/#uid/private_profile/#uid/survey/#uid/activities_responses';
  String milestoneResponsePath = '/users/#uid/private_profile/#uid/survey/#uid/milestone_responses';
  String positionPath = '/users/#uid/positions';

  final _log = Logger('IPacientService');
  final HttpsCallable callableMobErasPacientPush = CloudFunctions.instance.getHttpsCallable(
    functionName: 'pacientPush',
  );

  @override
  Future<void> changeTheme(ThemeCfg theme, String uid) {
    return null;
  }

  @override
  Future<List<UserProfile>> findByNameOrCpf(String name, String cpf) async {
    Query query = Collection<UserProfile>(path: 'users').ref;

    if (name != null && name.isNotEmpty) {
      query = query.where('displayName', isGreaterThanOrEqualTo: name);
    }
    if (cpf != null && cpf.isNotEmpty) {
      query = query.where('cpf', isEqualTo: cpf);
    }

    var snapshots = await query.getDocuments();
    return snapshots.documents.map((doc) => UserProfile.fromData(doc.data)).toList();
  }

  @override
  Future<List<UserProfile>> listAll() {
    return Collection<UserProfile>(path: 'users').getData();
  }

  @override
  Future<void> sendMsg(String uid, String msg) async {
    try {
      var data = {'uid': uid, 'msg': msg};
      await callableMobErasPacientPush.call(data);
    } catch (e) {
      _log.severe('sendpush', e);
    }
  }

  @override
  Future<UserProfile> fetchByUID({String uid}) async => await UserProfileData().getDocument();

  @override
  Future<List<ActivityResponse>> fetchDynamicResponseList(String uid) async {
    String path = dynamicResponsePath.replaceAll('#uid', uid);
    return await Collection<ActivityResponse>(path: path).getData();
  }

  @override
  Future<List<MilestoneResponse>> fetchMilestoneResponseList(String uid) async {
    String path = milestoneResponsePath.replaceAll('#uid', uid);
    return await Collection<MilestoneResponse>(path: path).getData();
  }

  @override
  Stream<List<ActivityResponse>> streamDynamicResponseList(String uid) {
    String path = dynamicResponsePath.replaceAll('#uid', uid);
    return Collection<ActivityResponse>(path: path).streamData();
    ;
  }

  @override
  Stream<List<MilestoneResponse>> streamMilestoneResponseList(String uid) {
    String path = milestoneResponsePath.replaceAll('#uid', uid);
    return Collection<MilestoneResponse>(path: path).streamData();
  }

  @override
  Future<List<PositionModel>> fecthPositions(String uid) async {
    String path = positionPath.replaceAll('#uid', uid);
    return await Collection<PositionModel>(path: path).getPositionData();
  }

  @override
  Future<int> calculateDistance(String uid) async {
    var positions = await fecthPositions(uid);
    if (positions.isNotEmpty) {
      var startPosition = positions[0];
      var endPosition = positions.last;
      return Future.value(Geolocator.distanceBetween(
              startPosition.position.latitude,
              startPosition.position.longitude,
              endPosition.position.latitude,
              endPosition.position.longitude)
          .toInt());
    } else {
      return Future.value(0);
    }
  }
}
