import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetProvider extends GetxController {
  static InternetProvider get instance => Get.find();
  RxBool _hasInternet = false.obs;
  RxBool get hasInternet => _hasInternet;

  InternetProvider() {
    checkInternetConnection();
  }

  Future checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _hasInternet = false.obs;
    } else {
      _hasInternet = true.obs;
    }
  }
}
