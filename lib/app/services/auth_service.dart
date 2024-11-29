// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:taller/app/data/models/taller/empleado.dart';
import 'package:taller/app/repositories/auth_repository.dart';
import 'package:taller/app/repositories/taller_repository.dart';
import 'package:taller/app/routes/app_pages.dart';
import 'package:taller/app/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:taller/app/services/taller_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final Logger log = Logger();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late final Rx<User?> _firebaseUser;
  User? get firebaseUser => _firebaseUser.value;

  RxBool _isSignedIn = false.obs;
  RxBool get isSignedIn => _isSignedIn;

  final TallerService tallerService =
      Get.put(TallerService(tallerRepository: Get.put(TallerRepository())));

  final AuthRepository authRepository = Get.put(AuthRepository());

  @override
  void onInit() {
    super.onInit();
    _firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    _firebaseUser.bindStream(firebaseAuth.userChanges());
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log.f('Error al iniciar sesión con Google en metodo signInWithGoogle');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);
      //La asignación se hace automaticamente con el bindStream
      //_firebaseUser.value = userCredential.user;
      _isSignedIn.value = true;
    } catch (e) {
      log.e('Error signing in with Google: $e');
    }
  }

  void setInitialScreen() {
    if (firebaseUser == null) {
      Get.offAllNamed(Routes.login);
    } else if (firebaseUser!.emailVerified) {
      //*Si el empleado tiene asociado un taller va la pantalla home si no va a la pantalla taller
      tallerService
          .empleadoAsociadoATaller(firebaseUser!.email!)
          .then((tallerAsociado) {
        if (tallerAsociado?.id == null) {
          Get.offAllNamed(Routes.taller);
        } else {
          tallerService.setTaller = tallerAsociado!;
          Get.offAllNamed(Routes.home);
        }
      });
    } else {
      Get.offNamed(Routes.verify);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await _googleSignIn.signOut();
    _isSignedIn.value = false;
    _firebaseUser.value = null;
    await clearStoredData();
  }

  Future userSignOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    _isSignedIn = false.obs;
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  Future<String?> getToken() async {
    final User? user = firebaseAuth.currentUser;

    if (user != null) {
      // Obtener el token de ID del usuario autenticado
      String? token = await user.getIdToken();
      log.i('TOKEN -> $token');
      if (token == null) {
        log.f('Error el token es null!');
      }

      return token;
    }
    log.f('Error al obtener el usuario de google fallo externo');
    return null;
  }

  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _firebaseUser.value = userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message;
      String code = 'ni se ha seteado';
      if (e.code == 'wrong-password') {
        message = 'Credenciales invalidas';
        code = e.code;
      } else if (e.code == 'invalid-email') {
        message = 'El email es invalido';
        code = e.code;
      } else if (e.code == 'user-not-found') {
        message =
            'Error con el usuario al iniciar sesión, porfavor registrese en nuestra plataforma';
        code = e.code;
      } else {
        message = 'Error generico al iniciar sesión con email y contraseña';
        code = e.code;
      }

      log.f('Error al iniciar sesión con usuario y contraseña -> $code');

      openSnackbar(Get.context, message, Colors.red);
      throw FirebaseException;
    }
  }

  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      if (user == null) {
        openSnackBar(
            "El usuario al registrarse con email y contraseña es null");
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          log.w('The password provided is too weak.');
          openSnackBar('The password provided is too weak.');
          break;
        case "email-already-in-use":
          log.e('The account already exists for that email.');
          openSnackBar('The account already exists for that email.');
          break;
        case "account-exists-with-different-credential":
          log.f('You already have an account with us. Use correct provider');
          openSnackBar(
              'You already have an account with us. Use correct provider');
          break;

        case "null":
          openSnackBar('Some unexpected error while trying to sign in');
          log.f('Some unexpected error while trying to sign in');
          break;

        case 'user-disabled':
          log.f('userDisabled');
          openSnackBar('userDisabled');
          break;

        case 'wrong-password':
          log.f('wrongPassword');
          openSnackBar('wrongPassword');
          break;

        case 'invalid-credential':
          log.f('invalidCredential');
          openSnackBar('invalidCredential');
          break;
        case 'operation-not-allowed':
          log.f('operationNotAllowed');
          openSnackBar('operationNotAllowed');
          break;
        case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
        default:
          openSnackBar(
              'La aplicación ha tenido un problema a la hora de autentificarte pongase en contacto con antoniojesuspv99@gmail.com');
      }
    } catch (e) {
      log.f('Error al registrar un usuario con email y contraseña -> $e');
    }
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmailVerification() async {
    try {
      await firebaseAuth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      log.f('Error en sendEmailVerification ${e.code}');
      throw e.code;
    } catch (_) {
      log.f('Error catch sendEmailVerification');
    }
  }

  void openSnackBar(String msg) {
    openSnackbar(Get.context, msg, Colors.red);
  }

  Future<bool> userExists() async {
    return await authRepository.getEmpleadoByUid(firebaseUser!.uid) != null
        ? true
        : false;
  }

  /*Future<void> saveUserDataToFirestore(String provider) async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid);
    await r.set({
      "name": firebaseUser!.displayName,
      "email": firebaseUser!.email,
      "uid": firebaseUser!.uid,
      "image_url": firebaseUser!.photoURL,
      "provider": provider,
    });
  }*/

  Future<void> saveEmpleado(String privider) async {
    Empleado empleado = Empleado(
      uid: firebaseUser!.uid,
      email: firebaseUser!.email ?? 'ERROR',
      displayName: firebaseUser!.displayName ?? 'no definido aun',
      photoUrl: firebaseUser!.photoURL ?? 'no definido aun',
      provider: privider,
    );

    await authRepository.saveEmpleado(empleado);
  }
}
