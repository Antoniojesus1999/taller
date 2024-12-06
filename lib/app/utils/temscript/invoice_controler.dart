// import 'package:app_taller/app/data/models/coches/model.dart';
// import 'package:app_taller/app/data/models/taller/client.dart';
// import 'package:app_taller/app/data/models/taller/vehicle.dart';
// import 'package:app_taller/app/routes/app_pages.dart';
// import 'package:app_taller/app/services/brand_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import '../../data/models/taller/repair.dart';

// class InvoiceController extends GetxController {
//   List<Model> modelList = [];
//   List<String> modelNameList =[];

//   final Logger log = Logger();
//   final BrandService brandSeervice = Get.put(BrandService());

//   final RoundedLoadingButtonController btnCntl =
//       RoundedLoadingButtonController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController nameCntrl = TextEditingController();
//   final surName1Cntrl = TextEditingController();
//   final surName2Cntrl = TextEditingController();
//   final nifCntrl = TextEditingController();
//   final tlfCntrl = TextEditingController();
//   final emailCntrl = TextEditingController();
//   final brandCntrl = TextEditingController();
//   final modelCntrl = TextEditingController();
//   final registrationCntrl = TextEditingController();
//   Rx<TextEditingValue> initValueBrand = const TextEditingValue().obs;
//   Rx<TextEditingValue> initValueModel = const TextEditingValue().obs;

//   //Seteamos el cliente que necesita la siguiente pagina para factura
//   static Client client = Client();
//   //Podemos poner final por que el contexto de GetX maneja el estado y siendo final puede cambiar su valor
//   final RxBool changedListBrand = RxBool(false);

//   @override
//   void onInit() {
//     super.onInit();
//     changeBrandAndModel();
//   }

//   void setData() async {
//     if (!formKey.currentState!.validate()) {
//       log.i("Formulario de login no correcto");
//       btnCntl.reset();
//     } else {
//       log.i("Formulario de login correcto");
//       client.name = nameCntrl.text;
//       client.surName1 = surName1Cntrl.text;
//       client.surName2 = surName2Cntrl.text;
//       client.nif = nifCntrl.text;
//       client.tlfn = tlfCntrl.text;
//       client.email = emailCntrl.text;
//       //TODO : de momento se mete siempre sobreescribiendo si tiene un coche ya se verá
//       List<Repair> repairList = [Repair(dateStart: DateTime.now())];
//       client.cars = [
//         Vehicle(
//             model: modelCntrl.value.text,
//             brand: brandCntrl.value.text,
//             registration: registrationCntrl.text,
//             repairs: repairList)
//       ];
//       btnCntl.success();
//       Get.toNamed(Routes.roberto);
//     }
//   }

//   Future<void> changeBrandAndModel() async {
//     changedListBrand.value = true;
//     try {
//       log.i('Haciendo petición desde el controller para recuperar las marcas');
//       await BrandService.getBrand('brands').then((_) {
//         log.i('Cargando nombre marcas');
//         final stopwatch = Stopwatch()..start();
//         modelList = BrandService.listModel;

//         log.i('Cargando nombre modelos');
//         modelNameList = BrandService.listNameModel.obs;

//         //Hacemos una copia para usarla en el controller ya que si se selecciona una marca la lista de modelo se reduce y luego se tiene que poder volver a meter todos los modelos recuperandolo del service.
//         log.i('Haciendo copia de los modelos en la lista del controller');
//         modelNameList = BrandService.listNameModel.obs;
//         log.i(
//             'Ha tardado en cargar en listas el resultado ${stopwatch.elapsedMilliseconds} milisegundos');
//       });
//     } catch (e) {
//       log.f('Error al cargar las marcas');
//       throw Exception('Error al cargar las marcas');
//     } finally {
//       changedListBrand.value = false;
//     }
//   }

//   ///Se usa para en el autocomplete cuando hace clic en una opción
//   void handleBrandSelection(String nameBrand) {
//     log.i('Se ha marcado la marca $nameBrand');
//     //creamos un modelo por si no se encontrara

//     //Obtenemos el nomber del text y buscamos el id para poder sacar el modelo
//     int idBrand = BrandService.findBrandByName(nameBrand);
//     String modelName = BrandService.listModel
//         .firstWhere((model) => model.idMarca == idBrand,
//             orElse: () => BrandService.brandNotFound.models[0])
//         .name;
//     //Metemos en el modelo el valor
//     //modelCntrl.value.text = modelName;
//     initValueModel.value = TextEditingValue(text: modelName);
//     log.i('valor initValueModel.valu $initValueModel');

//     modelList = BrandService.listBrand
//         .firstWhereOrNull((brand) => brand.name == nameBrand)!
//         .models
//         .obs;
//     modelNameList = modelList.map((model) => model.name).toList();
//     log.i('Cargado los modelos de la marca que ha seleccionado $modelList');
//   }

//   void handleModelSelection(String nameModel) {
//     log.i('Se ha marcado la marca $nameModel');
//     int idBrand = BrandService.findModelByName(nameModel);
//     //Seleccionamos la marca apartir del nombre del modelo;
//     String brandNme =
//         BrandService.listBrand.firstWhere((brand) => brand.id == idBrand).name;
//     initValueBrand.value = TextEditingValue(text: brandNme);
//   }
// }
