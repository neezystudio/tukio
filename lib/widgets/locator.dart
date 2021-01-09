import 'package:get_it/get_it.dart';

import 'package:tukio/widgets/auth_repo.dart';
import 'package:tukio/widgets/storagerepo.dart';
import 'package:tukio/widgets/user_controller.dart';
//import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthRepo>(AuthRepo());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<UserController>(UserController());
}
