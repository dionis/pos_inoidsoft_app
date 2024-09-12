import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/models/vendor.dart';

class VendorSenttings extends StatelessWidget {
  final _formVendorSettingsKey = GlobalKey<FormState>();
  late Vendor vendorData;
  File? selectedImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController identificationNumberController =
      TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController magneticCartController = TextEditingController();

  String VENDOR_NAME = 'Nombre';
  String UPDATE_IMAGE = "Actualizar imagen:";

  int VENDOR_NAME_LENGTH = 70;

  String ADD_VENDOR_NAME = 'Nombre del vendedor';

  String FLOAT_REGULAR_EXPRESSION = r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$';
  String INTEGER_REGULAR_EXPRESSION = r'^([0-9]+)$';
  String TEXT_ALPHANUMERIC_SPACE = r'^[a-zA-Z0-9 _-]*$';

  String ERROR_VENDOR_NAME_EMPTY = 'El nombre del vendedor es obligatorio';

  String ERROR_VENDOR_NAME_REGULAR_EXPRESSION =
      "El nombre del vendedor solo puede contener letras y números";

  String ERROR_IDENTIFICATOR_NUMBER_EMPTY =
      'El carnet de identidad es obligatorio';

  String ERROR_IDENTIFICATOR_NUMBER_REGULAR_EXPRESSION =
      "El carnet de identidad solo puede contener números";

  String IDENTIFICATION_NUMBER_TITLE = 'Carnet de Identidad';

  int IDENTIFICATION_NUMBER_LENGTH = 11;

  int PHONE_NUMBER_LENGTH = 8;

  String PHONE_NUMBER_TITLE = 'Teléfono';

  String ERROR_PHONE_NUMBER_EMPTY = 'El número de teléfono es obligatorio';

  String ERROR_MAGNETIC_CART_EMPTY = 'El número de teléfono es obligatorio';

  String ERROR_PHONE_NUMBER_REGULAR_EXPRESSION =
      'El número de teléfono solo puede contener números';

  int MAGNETIC_CART_NUMBER_LENGTH = 12;

  String MAGNETIC_CART_NUMBER_TITLE = 'Número de tarjeta magnética';

  String ERROR_MAGNETIC_CART_NUMBER_EMPTY =
      'El número de targeta magnética es obligatorio';

  String ERROR_MAGNETIC_CART_NUMBERR_REGULAR_EXPRESSION =
      'El número de targeta magnética solo puede contener números';

  VendorSenttings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formVendorSettingsKey,
        child: SingleChildScrollView(
          // margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(UPDATE_IMAGE,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(
                height: 2.0,
              ),
              showItemImages(),
              //Add or update Name
              const SizedBox(
                height: 10.0,
              ),
              Text(VENDOR_NAME, style: semiBoldTextFileStyle()),
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
                  maxLength: VENDOR_NAME_LENGTH,
                  controller: nameController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_VENDOR_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                  validator: (value) {
                    RegExp re = RegExp(TEXT_ALPHANUMERIC_SPACE);

                    if (value!.isEmpty) {
                      return ERROR_VENDOR_NAME_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_VENDOR_NAME_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(IDENTIFICATION_NUMBER_TITLE, style: semiBoldTextFileStyle()),
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
                  maxLength: IDENTIFICATION_NUMBER_LENGTH,
                  controller: identificationNumberController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_VENDOR_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                  validator: (value) {
                    RegExp re = RegExp(INTEGER_REGULAR_EXPRESSION);

                    if (value!.isEmpty) {
                      return ERROR_IDENTIFICATOR_NUMBER_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_IDENTIFICATOR_NUMBER_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(PHONE_NUMBER_TITLE, style: semiBoldTextFileStyle()),
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
                  maxLength: PHONE_NUMBER_LENGTH,
                  controller: identificationNumberController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_VENDOR_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                  validator: (value) {
                    RegExp re = RegExp(INTEGER_REGULAR_EXPRESSION);

                    if (value!.isEmpty) {
                      return ERROR_PHONE_NUMBER_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_PHONE_NUMBER_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              //Add or update Price
              const SizedBox(
                height: 10.0,
              ),
              Text(MAGNETIC_CART_NUMBER_TITLE, style: semiBoldTextFileStyle()),
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
                  maxLength: MAGNETIC_CART_NUMBER_LENGTH,
                  controller: magneticCartController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_VENDOR_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                  validator: (value) {
                    RegExp re = RegExp(INTEGER_REGULAR_EXPRESSION);

                    if (value!.isEmpty) {
                      return ERROR_MAGNETIC_CART_NUMBER_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_MAGNETIC_CART_NUMBERR_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              //Add or update Price
            ],
          ),
        ),
      ),
    );
  }

  TextStyle semiBoldTextFileStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  }

  Widget showItemImages() {
    return selectedImage == null
        ? Center(
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.camera_alt_outlined,
                      color: Colors.black)),
            ),
          )
        : Center(
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: vendorData.avatarImage.contains('asset')
                        ? Image.asset(vendorData.avatarImage)
                        : Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                  )),
            ),
          );
  }
}
