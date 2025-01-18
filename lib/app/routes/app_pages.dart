import 'package:taller/app/bindings/firma_bindiing.dart';
import 'package:taller/app/bindings/form_vehiculo_binding.dart';
import 'package:taller/app/bindings/home_binding.dart';
import 'package:taller/app/bindings/form_persona_binding.dart';
import 'package:taller/app/bindings/pdf_binding.dart';
import 'package:taller/app/bindings/register_binding.dart';
import 'package:taller/app/bindings/reset_binding.dart';
import 'package:taller/app/bindings/taller_binding.dart';
import 'package:taller/app/bindings/trabajo_binding.dart';
import 'package:taller/app/bindings/verification_binding.dart';
import 'package:taller/app/ui/pages/auth/register_page.dart';
import 'package:taller/app/ui/pages/auth/verify_page.dart';
import 'package:taller/app/ui/pages/home/taller_page.dart';
import 'package:get/get.dart';
import 'package:taller/app/ui/pages/pdf/pdf_page.dart';
import 'package:taller/app/ui/pages/reparacion/firma_page.dart';
import 'package:taller/app/ui/pages/home/trabajo_page.dart';
import 'package:taller/app/ui/pages/reparacion/form_persona_page.dart';
import 'package:taller/app/ui/pages/reparacion/select_vehiculo_page.dart';

import '../bindings/form_danyos_bindiing.dart';
import '../bindings/login_binding.dart';
import '../bindings/reparacion_detail_binding.dart';
import '../bindings/select_vehiculo_binding.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/auth/login_page.dart';
import '../ui/pages/auth/reset_password_page.dart';
import '../ui/pages/reparacion/form_vehiculo_page.dart';
import '../ui/pages/reparacion/danyos_page.dart';
import '../ui/pages/reparacion/reparacion_detail_page.dart';
part 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.login,
        binding: LoginBinding(),
        page: () => LoginPage(),
        transition: Transition.upToDown),
    GetPage(
        name: Routes.home,
        binding: HomeBinding(),
        page: () => const HomePage(),
        transition: Transition.upToDown),
    GetPage(
        name: Routes.register,
        binding: RegisterBinding(),
        page: () => RegisterPage(),
        transition: Transition.cupertino),
    GetPage(
        name: Routes.reset,
        binding: ResetBinding(),
        page: () => ResetPasswordPage(),
        transition: Transition.zoom),
    GetPage(
        name: Routes.verify,
        binding: VerificationBinding(),
        page: () => VerifyPage(),
        transition: Transition.upToDown),
    GetPage(
        name: Routes.formPerson,
        binding: FormPersonaBinding(),
        //page: () => const FormPersonPage(),
        page: () => const FormPersonaPage(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: Routes.formVehicle,
        page: () => const FormVehiculoPage(),
        binding: FormVehiculoBinding(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: Routes.imageWithMarkers,
        page: () => ImageWithMarkers(),
        binding: ImageWithMarkersBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.firmar,
        page: () => FirmaPage(),
        binding: FirmaBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.pageReparacionesDetail,
        page: () => const ReparacionDetailPage(),
        binding: ReparacionDetailBinding(),
        transition: Transition.circularReveal),
    GetPage(
        name: Routes.taller,
        page: () => const TallerPage(),
        binding: TallerBinding(),
        transition: Transition.circularReveal),
    GetPage(
        name: Routes.selectVehicle,
        page: () => const SelectVehiculoPage(),
        binding: SelectVehiculoBinding(),
        transition: Transition.size),
    GetPage(
        name: Routes.formTrabajos,
        page: () => const TrabajoPage(),
        binding: TrabajoBinding(),
        transition: Transition.rightToLeftWithFade),
         GetPage(
        name: Routes.viewPdf,
        page: () => const PdfPage(),
        binding: PdfBinding(),
        transition: Transition.cupertino),
  ];
}
