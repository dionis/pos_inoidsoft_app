import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:uuid/uuid.dart';

import '../../../constant.dart';
import '../../../data/models/vendor.dart';
import '../../widgets/take_picture.dart';

class VendorSenttings extends ConsumerWidget {
  final _formVendorSettingsKey = GlobalKey<FormState>();
  late Vendor vendorData;
  File? selectedImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController identificationNumberController =
      TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController magneticCartController = TextEditingController();

  int VENDOR_NAME_LENGTH = 70;

  String FLOAT_REGULAR_EXPRESSION = r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$';
  String INTEGER_REGULAR_EXPRESSION = r'^([0-9]+)$';
  String TEXT_ALPHANUMERIC_SPACE = r'^[a-zA-Z0-9 _-]*$';

  int IDENTIFICATION_NUMBER_LENGTH = 11;

  int PHONE_NUMBER_LENGTH = 8;

  VendorSenttings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    vendorData = ref.watch(currentSelectedVendorSettingsProvider);

    Future(() {
      ref.read(currentSelectedImageProvider.notifier).updateImage =
          vendorData.avatarImage;
    });

    nameController.text = vendorData.name;
    identificationNumberController.text = vendorData.idSerialNumber;
    phoneController.text = vendorData.phoneNumber;
    magneticCartController.text = vendorData.magneticCart;

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
              TakePicture(updateImage: (String path) {
                if (path.isNotEmpty) {
                  vendorData.avatarImage = path;

                  ref
                      .read(currentSelectedVendorSettingsProvider.notifier)
                      .updateSettings = vendorData;
                }
              }),
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
                  controller: phoneController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_PHONE_NUMBER,
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
                      hintText: ADD_ACCOUNT_NUMBER,
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
    if (_formVendorSettingsKey.currentState!.validate()) {
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
        vendorData.name = nameController.text;
        vendorData.phoneNumber = phoneController.text;
        vendorData.idSerialNumber = identificationNumberController.text;
        vendorData.magneticCart = magneticCartController.text;

        //Go to PostSreen or Item List
        ref
            .read(currentSelectedVendorSettingsProvider.notifier)
            .updateSettings = vendorData;
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
