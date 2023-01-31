import 'package:get/get.dart';
import 'package:admin/Controllers/add_assets.dart';
import 'package:admin/Controllers/add_branch.dart';
import 'package:admin/Controllers/add_category.dart';
import 'package:admin/Controllers/add_city.dart';
import 'package:admin/Controllers/add_user.dart';
import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/Controllers/login_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
    Get.put(CreateUserController(), permanent: true);
    Get.put(AddBranchController(), permanent: true);
    Get.put(AddCategoryController(), permanent: true);
    Get.put(AddCityController(), permanent: true);
    Get.put(AddAssetsController(), permanent: true);
    Get.put(DashboardController(), permanent: true);
  }
}
