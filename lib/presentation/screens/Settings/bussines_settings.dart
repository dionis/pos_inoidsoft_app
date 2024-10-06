import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:uuid/uuid.dart';

import '../../../constant.dart';
import '../../../data/models/bussines.dart';
import '../../widgets/take_picture.dart';

class BussinesSettings extends ConsumerWidget {
  final _formSettingsKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String BUSSINES_NAME = 'Nombre del negocio';

  int BUSSINES_NAME_LENGTH = 100;

  String ADD_BUSSINES_NAME = 'Nombre o Titulo';

  String TEXT_ALPHANUMERIC_SPACE = r'^[a-zA-Z0-9 _-]*$';
  String INTEGER_REGULAR_EXPRESSION = r'^([0-9]+)$';

  String ERROR_BUSSINES_NAME_EMPTY = 'El nombre es obligatorio';

  String ERROR_BUSSINES_NAME_REGULAR_EXPRESSION =
      "El nombre del negocio o establecimiento solo puede contener letras o números";

  String BUSINESS_ADDRESS = 'Dirección del negocio';

  String BUSSINES_PHONE_NUMBER = 'Telefono:';

  String ERROR_BUSSINES_PHONE_EMPTY =
      'El número de teléfono no debe estar vacio';

  String ERROR_BUSSINES_PHONE_REGULAR_EXPRESSION =
      "El número de teléfono del negocio o establecimiento solo puede contener números y el símbolo +";

  int BUSINESS_ADDRESS_LIMIT = 150;

  String ADD_BUSSINES_ADDRESS = 'Dirección';

  File? selectedImage;

  late Bussines bussinesData;

  BussinesSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bussinesData = ref.watch(currentBussinesSettingsProvider);

    Future(() {
      ref.read(currentSelectedImageProvider.notifier).updateImage =
          bussinesData.image;
    });

    nameController.text = bussinesData.name;
    addressController.text = bussinesData.address;
    String phoneNumbers = bussinesData.phoneNumbers
        .fold("", (tot, item) => tot.isEmpty ? item : "$tot ; $item");
    phoneController.text = phoneNumbers;

    return Scaffold(
      body: Form(
        key: _formSettingsKey,
        child: SingleChildScrollView(
          // margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 2.0,
              ),
              const SizedBox(
                height: 2.0,
              ),
              TakePicture(updateImage: (String path) {
                if (path.isNotEmpty) {
                  bussinesData.image = path;

                  ref
                      .read(currentBussinesSettingsProvider.notifier)
                      .updateSettings = bussinesData;
                }
              }),
              const SizedBox(
                height: 10.0,
              ),
              Text(BUSSINES_NAME, style: semiBoldTextFileStyle()),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  maxLength: BUSSINES_NAME_LENGTH,
                  controller: nameController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_BUSSINES_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                  validator: (value) {
                    RegExp re = RegExp(TEXT_ALPHANUMERIC_SPACE);

                    if (value!.isEmpty) {
                      return ERROR_BUSSINES_NAME_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_BUSSINES_NAME_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              //Add or update Price
              const SizedBox(
                height: 10.0,
              ),
              Text(BUSSINES_PHONE_NUMBER, style: semiBoldTextFileStyle()),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  maxLength: BUSSINES_NAME_LENGTH,
                  controller: phoneController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_BUSSINES_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                  validator: (value) {
                    RegExp re = RegExp(INTEGER_REGULAR_EXPRESSION);

                    if (value!.isEmpty) {
                      return ERROR_BUSSINES_PHONE_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_BUSSINES_PHONE_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(BUSINESS_ADDRESS, style: semiBoldTextFileStyle()),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  maxLines: 3,
                  maxLength: BUSINESS_ADDRESS_LIMIT,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  controller: addressController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_BUSSINES_ADDRESS,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kprimaryColor,
        tooltip: ACTION_BUTTON,
        onPressed: () {
          updateItem(context, ref);
        },
        child: const Icon(Icons.save_as, color: Colors.white, size: 28),
      ),
    );
  }

  TextStyle semiBoldTextFileStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  }

  updateItem(BuildContext context, WidgetRef ref) {
    if (_formSettingsKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );

      if (nameController.text.isNotEmpty) {
        /**
           * Bibliografy
           *   var uuid = Uuid();
              // Generate a v1 (time-based) id
              uuid.v1();   // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
              // Generate a v4 (random) id
              uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

              Uiid Package information
                https://pub.dev/packages/uuid

      */
        String addId = Uuid().v1();

        ///Save or Update in Database or list
        ///
        ///
        bussinesData.name = nameController.text;
        bussinesData.phoneNumbers = phoneController.text.split(";");
        bussinesData.address = addressController.text;

        //Go to PostSreen or Item List
        ref.read(currentBussinesSettingsProvider.notifier).updateSettings =
            bussinesData;
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("Homeboard", 0);
      }
    } else {
      // Display an error message if the form is not valid.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ERROR_IN_DATA)),
      );
    }
  }
}
