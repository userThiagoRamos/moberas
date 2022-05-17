import 'package:injectable/injectable.dart';
import 'package:moberas_dashboard/database/firestore.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';
import 'package:moberas_dashboard/features/response/service/response_service_interface.dart';

@Singleton(as: IResponseService)
class ResponseService implements IResponseService {
  @override
  Stream<List<ActivityResponse>> activityResponse$({String uid}) {
    return Collection<ActivityResponse>(
            path:
                '/users/$uid/private_profile/$uid/survey/$uid/activities_responses')
        .streamData();
  }
}
