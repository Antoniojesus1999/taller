import 'package:taller/app/routes/app_pages.dart';
import 'package:taller/app/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthService()));
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      //theme: appThemeData,
      defaultTransition: Transition.fade,
      //initialBinding: SplashBinding(),
      getPages: AppPages.pages));
}



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   ).then((FirebaseApp value) => Get.put(AuthController()));
//   runApp(
//     //Todo: Cuando subamos hay que quitar el device preview
//     DevicePreview(
//         enabled: true,
//         tools: const [
//           ...DevicePreview.defaultTools,
//         ],
//         builder: (context) => GetMaterialApp(
//             debugShowCheckedModeBanner: false,
//             initialRoute: Routes.login,
//             //TODO: Tema
//             //theme: appThemeData,
//             defaultTransition: Transition.fade,
//             //initialBinding: SplashBinding(),
//             getPages: AppPages.pages)),
//   );
// }

// void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  ).then((FirebaseApp value) => Get.put(AuthController()));
//  runApp(GetMaterialApp(
//      debugShowCheckedModeBanner: false,
//      initialRoute: Routes.login,
//      theme: appThemeData,
//      defaultTransition: Transition.fade,
//      initialBinding: SplashBinding(),
//      getPages: AppPages.pages));
// }



