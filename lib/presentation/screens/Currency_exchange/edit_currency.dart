import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_inoidsoft_app/presentation/providers/currency_coin_exchange.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:uuid/uuid.dart';

import '../../../constant.dart';
import '../../../data/models/exchange_coin.dart';
import '../../providers/config_state_variables.dart';
import '../../widgets/number_edit_attribute.dart';

class EditCurrencyWidget extends ConsumerWidget {
  final String eventTitle;

  String CRUD_ITEM_TITLE = ' Producto';

  TextEditingController nameController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String FLOAT_REGULAR_EXPRESSION = r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$';
  String INTEGER_REGULAR_EXPRESSION = r'^([0-9]+)$';
  String TEXT_ALPHANUMERIC_SPACE = r'^[a-zA-Z0-9 _-]*$';

  final ImagePicker _imagePicker = ImagePicker();
  String ACTION_BUTTON = 'Add';

  File? selectedImage;

  final _formKey = GlobalKey<FormState>();

  String UPDATE_IMAGE = "Actualizar imagen:";

  String CURRENCY_NAME = 'Nombre';

  int CURRENCY_NAME_LENGTH = 70;
  int RATE_LIMIT = 100000;
  int DESCRIPTION_LIMIT = 500;

  String ADD_CURRENCY_NAME = 'Añadir nombre';

  String ERROR_CURRENCY_NAME_EMPTY = 'El nombre de la moneda es obligatorio';

  String ERROR_CURRENCY_NAME_REGULAR_EXPRESSION =
      "El nombre de la moneda  solo puede contener letras y números";

  String CURRENCY_RATE = 'Taza de cambio';

  String ADD_RATE = 'Añadir valor';

  String BAD_RATE_ZERO_OR_NEGATIVE = 'El valor debe ser mayor que 0';
  String BAD_RATE_NOT_VALID = 'No es un valor correcto, revise por favor';
  String ERROR_IN_DATA = 'Los datos tienen errores, revise por favor';
  String CURRENCY_RATE_DESCRIPTION = "Detalles:";

  String ADD_DESCRIPTION = 'Añadir detalles';
  String DEFAULT_IMAGE = "assets/no-image.jpg";
  String ACTION_EVENT = 'Add';

  late ExchangeCoin selectedItem = ExchangeCoin();

  int indexSelectedItem = 0;

  EditCurrencyWidget({
    super.key,
    required this.eventTitle,
  }) {
    CRUD_ITEM_TITLE =
        eventTitle == ADD_PRODUCT ? 'Agregar Producto' : 'Editar Producto';
    ACTION_BUTTON = eventTitle == ADD_PRODUCT ? 'Agregar' : 'Actualizar';
    ACTION_EVENT = selectedItem.title == '' ? 'Add' : 'Update';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    selectedItem = ref.watch(selectedCoinProvider);

    selectedImage = File(selectedItem.image);

    indexSelectedItem = ref.watch(selectedCoinIndexProvider);

    nameController.text = selectedItem.title;
    rateController.text = selectedItem.rate.toStringAsFixed(2);

    return Scaffold(
      body: Form(
        key: _formKey,
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
              const SizedBox(
                height: 10.0,
              ),
              Text(CURRENCY_NAME, style: semiBoldTextFileStyle()),
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
                  maxLength: CURRENCY_NAME_LENGTH,
                  controller: nameController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_CURRENCY_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  validator: (value) {
                    RegExp re = RegExp(TEXT_ALPHANUMERIC_SPACE);

                    if (value!.isEmpty) {
                      return ERROR_CURRENCY_NAME_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_CURRENCY_NAME_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              //Add or update Price
              const SizedBox(
                height: 10.0,
              ),
              Text(CURRENCY_RATE, style: semiBoldTextFileStyle()),
              const SizedBox(
                height: 2.0,
              ),
              NumberEditAttribute(
                hintLabel: ADD_RATE,
                mcontroller: rateController,
                limitSize: RATE_LIMIT,
                increment: () {
                  rateController.text =
                      (toDouble(rateController.text) + 1).toStringAsFixed(2);
                  toString;
                },
                decrement: () {
                  rateController.text =
                      (toDouble(rateController.text) - 1).toStringAsFixed(2);
                },
                validatorFunction: (value) {
                  // instead of returning the error messages here
                  // we assign the error message to the _validationError state
                  // so that we can show the error message elsewhere

                  //Regex float number [-+]?[0-9]*\.?[0-9]*
                  RegExp re = RegExp(FLOAT_REGULAR_EXPRESSION);
                  var resultMessage;
                  double numberPrice = toDouble(value ?? "0.0");

                  if (!re.hasMatch(value ?? "")) {
                    resultMessage = BAD_RATE_NOT_VALID;
                  } else if (numberPrice <= 0) {
                    resultMessage = BAD_RATE_ZERO_OR_NEGATIVE;
                  }

                  return resultMessage;
                },
              ),
              //Add or update Detail
              const SizedBox(
                height: 10.0,
              ),
              Text(CURRENCY_RATE_DESCRIPTION, style: semiBoldTextFileStyle()),
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
                  maxLength: DESCRIPTION_LIMIT,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_DESCRIPTION,
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
                    child: selectedItem.image.contains('asset')
                        ? Image.asset(selectedItem.image)
                        : Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                  )),
            ),
          );
  }

  updateItem(BuildContext context, WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      if (nameController.text.isNotEmpty && rateController.text.isNotEmpty) {
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

        selectedItem.image = (selectedImage != null)
            ? selectedItem.image = selectedImage!.path
            : DEFAULT_IMAGE;

        selectedItem.title = nameController.text;
        selectedItem.rate = double.parse(rateController.text);
        selectedItem.description = descriptionController.text;

        //Update or Add item in the list
        if (ACTION_EVENT != 'Update') {
          //selectedImage.id = addId;
          ref.read(itemsExchangeCoinProvider.notifier).createCoin(selectedItem);
        } else {
          //Update on some list
          ref
              .read(itemsExchangeCoinProvider.notifier)
              .updateCoin(selectedItem, indexSelectedItem);
        }

        //Go back to HomeDashBoard
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

  TextStyle semiBoldTextFileStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  }

  Future getImage() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
  }
}
