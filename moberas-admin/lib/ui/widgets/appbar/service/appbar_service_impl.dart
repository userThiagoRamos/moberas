import 'package:injectable/injectable.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/models/user_profile.dart';
import 'package:mobEras/ui/widgets/appbar/service/appbar_service_interface.dart';

@Singleton(as: IAppBarService)
class UserStatusServiceImpl extends IAppBarService {
  @override
  Stream<UserProfile> get userProfile$ => UserProfileData().streamDocument();
}
