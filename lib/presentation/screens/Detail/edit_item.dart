import 'dart:convert';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/providers/items_car_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/color_picker.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/take_picture.dart';
import 'package:random_name_generator/random_name_generator.dart';
import 'package:string_validator/string_validator.dart';
import 'package:uuid/uuid.dart';

import '../../../constant.dart';
import '../../../data/models/category.dart';
import '../../../data/models/product.dart';
import '../../providers/config_state_variables.dart';
import '../../widgets/number_edit_attribute.dart';
import '../../widgets/qr_image.dart';

class CrudItemScreen extends ConsumerWidget {
  String CRUD_ITEM_TITLE = ' Producto';
  final String eventTitle;

  String ITEM_NAME = 'Nombre:';

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController barCodeOrQrController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  File? selectedImage;

  String ADD_ITEN_NAME = "Nombre del producto";

  String ITEM_DESCRIPTION = "Detalles:";

  String ITEM_PRICE = 'Precio:';

  String ADD_PRICE = 'Añadir Precio';

  String ADD_DESCRIPTION = 'Añadir detalles';

  String? itemCategory = '';

  List<String> categoryList =
      List<String>.generate(5, (int i) => RandomNames(Zone.spain).fullName());

  late Product selectedItem;

  String ITEM_CATEGORY = "Categorías:";
  String ITEM_SELECT_COLORS = "Agregar color:";

  String UPDATE_IMAGE = "Actualizar imagen:";

  Color updateColorEvent = Colors.black;

  String ITEM_BARCODE_OR_QR = 'Código de barras / QR';

  String BARCODE_OR_QR_TEXT = "Código asociado";

  int currentColor = 0;

  Color pickerColor = Color(0xff443a49);

  String ITEM_QUANTITY = 'Cantidad';

  String ADD_QUANTITY = "Añadir cantidad";

  final _formKey = GlobalKey<FormState>();

  CrudItemScreen(
      {super.key,
      required this.eventTitle,
      this.currentSelectedCategory = "Others"}) {
    CRUD_ITEM_TITLE =
        eventTitle == ADD_PRODUCT ? 'Agregar Producto' : 'Editar Producto';
    ACTION_BUTTON = eventTitle == ADD_PRODUCT ? 'Agregar' : 'Actualizar';

    currentSelectedCategory = DEFAULT_CATEGORY;
  }

  //See definitions in:
  //   https://www.html-color-names.com/basic-color-names.php
  //   https://webapps.bcit.ca/mdia1205/1205Appendix/1205AppendixC/files/color-1.htm
  //

  Map<String, Color> colorCodes = {
    'red': Colors.red,
    'orange': Colors.orange,
    'yellow': Colors.yellow,
    'green': Colors.green,
    'blue': Colors.blue,
    'indigo': Colors.indigo,
    'violet': Colors.purple,
    'pink': Colors.pink,
    'black': Colors.black,
    'white': Colors.white,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'purple': Colors.purple,
    'lime': Colors.lime,
    'teal': Colors.teal,
    'cyan': Colors.cyan,
  };

  Color currentPickerColor = Colors.orange;

  String FLOAT_REGULAR_EXPRESSION = r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$';
  String INTEGER_REGULAR_EXPRESSION = r'^([0-9]+)$';
  String TEXT_ALPHANUMERIC_SPACE = r'^[a-zA-Z0-9 _-]*$';
  String ITEM_COLORS = "Colores: ";
  String ADD_COLORES = "Añadir colores: ";

  int PRODUCT_NAME_LENGTH = 70;
  int PRICE_LIMIT = 100000;
  int QUANTITY_LIMIT = 200000;

  String BAD_PRICE_ZERO_OR_NEGATIVE = 'El precio debe ser mayor que 0';
  String BAD_PRICE_NOT_VALID = 'No es un valor correcto, revise por favor';

  int DESCRIPTION_LIMIT = 500;

  String DEFAULT_IMAGE = "assets/no-image.jpg";

  final String DEFAULT_CATEGORY = "Others";

  int indexSelectedItem = 0;

  String ERROR_PRODUCT_NAME_EMPTY = 'El nombre del producto es obligatorio';

  String ERROR_PRODUCT_NAME_REGULAR_EXPRESSION =
      "El nombre del producto solo puede contener letras y números";

  String currentSelectedCategory = "Others";
  FilterType fromEditScreenEvent = FilterType.updateItemPos;

  String ACTION_EVENT = 'Add';

  String COLOR_EXISTS = 'El color ya existe';

  String PRINT_QR_PRODUCT = 'Imprimir QR del producto';

  late BuildContext oldDialogContext;

  String CANCEL_BUTTON_LABEL = 'Cancelar';

  List<String> _listCategoryName = [];

  int COLORS_LIMIT = 7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color currentPickerColor = colorCodes['orange'] ?? Colors.pink;
    selectedItem = ref.watch(selectedProductProvider);

    indexSelectedItem = ref.watch(selectedProductIndexProvider);

    fromEditScreenEvent = ref.watch(itemSalesCurrentFilterProvider);

    _validateFileExists(selectedItem.image).then((path) {
      ref.read(currentSelectedImageProvider.notifier).updateImage = path;
    });

    // selectedItem.image!.contains('assets')
    //     ? _validateFileExists(selectedItem.image)
    //     : selectedItem.image;

    if (selectedItem != null) {
      selectedImage = File(
          (selectedItem.image.isEmpty || selectedItem.image == '')
              ? "assets/no-image.jpg"
              : selectedItem.image);

      CRUD_ITEM_TITLE =
          selectedItem.title == '' ? 'Agregar Producto' : 'Editar Producto';
      ACTION_BUTTON = selectedItem.title == '' ? 'Agregar' : 'Actualizar';
      ACTION_EVENT = selectedItem.title == '' ? 'Add' : 'Update';
    }

    nameController.text = selectedItem.title;
    priceController.text = selectedItem.price.toString();
    int lengthDescriptionStr = selectedItem.description.length;
    descriptionController.text =
        selectedItem.description.isEmpty ? '' : selectedItem.description;

    // .substring(
    //     0, lengthDescriptionStr > 50 ? 50 : lengthDescriptionStr);
    barCodeOrQrController.text = selectedItem.barcode;
    quantityController.text = selectedItem.rate?.toInt()?.toString() ?? '0';

    BARCODE_OR_QR_TEXT = selectedItem.barcode;

    itemCategory = categoryList.elementAt(2);

    _listCategoryName = itemCategoriesEsMap.keys.toList();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                ///Print QR about ITEM
                ///

                Fluttertoast.showToast(
                    msg: PRINT_QR_PRODUCT, toastLength: Toast.LENGTH_SHORT);

                String currentItemJsonString =
                    jsonEncode(selectedItem.toJson());

                Navigator.push(context, MaterialPageRoute(
                  builder: ((context) {
                    return QRImage(currentItemJsonString);
                  }),
                ));
              },
              icon: const Icon(Icons.print_rounded),
              style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(15))),
          actions: [
            IconButton(
                onPressed: () {
                  updateItem(context, ref);
                },
                icon: const Icon(Icons.save_as),
                style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(15)))
          ],
          centerTitle: true,
          title: Text(CRUD_ITEM_TITLE,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
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
              TakePicture(updateImage: (String path) {
                if (path.isNotEmpty) {
                  ref.read(selectedProductProvider.notifier).image = path;
                }
              }),

              const SizedBox(
                height: 10.0,
              ),
              Text(ITEM_BARCODE_OR_QR, style: semiBoldTextFileStyle()),
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
                  readOnly: true,
                  controller: barCodeOrQrController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          ref
                              .read(itemSalesCurrentFilterProvider.notifier)
                              .changeCurrentFilter(FilterType.editItem);
                          ref
                              .read(currentIndexProvider.notifier)
                              .updateCurrentMainWidget("QrReaderCodeWindow", 1);
                        },
                      ),
                      hintText: BARCODE_OR_QR_TEXT,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                ),
              ),
              //Add or update Name
              const SizedBox(
                height: 10.0,
              ),
              Text(ITEM_NAME, style: semiBoldTextFileStyle()),
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
                  maxLength: PRODUCT_NAME_LENGTH,
                  controller: nameController,
                  decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: ADD_ITEN_NAME,
                      hintStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w300)),
                  validator: (value) {
                    RegExp re = RegExp(TEXT_ALPHANUMERIC_SPACE);

                    if (value!.isEmpty) {
                      return ERROR_PRODUCT_NAME_EMPTY;
                    } else if (!re.hasMatch((value ?? "").trim())) {
                      return ERROR_PRODUCT_NAME_REGULAR_EXPRESSION;
                    }

                    return null;
                  },
                ),
              ),
              //Add or update Price
              const SizedBox(
                height: 10.0,
              ),
              Text(ITEM_PRICE, style: semiBoldTextFileStyle()),
              const SizedBox(
                height: 2.0,
              ),
              NumberEditAttribute(
                hintLabel: ADD_PRICE,
                mcontroller: priceController,
                limitSize: PRICE_LIMIT,
                increment: () {
                  priceController.text =
                      (toDouble(priceController.text) + 1).toStringAsFixed(2);
                  toString;
                },
                decrement: () {
                  priceController.text =
                      (toDouble(priceController.text) - 1).toStringAsFixed(2);
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
                    resultMessage = BAD_PRICE_NOT_VALID;
                  } else if (numberPrice <= 0) {
                    resultMessage = BAD_PRICE_ZERO_OR_NEGATIVE;
                  }

                  return resultMessage;
                },
              ),
              //Add or update Detail
              const SizedBox(
                height: 10.0,
              ),
              Text(ITEM_QUANTITY, style: semiBoldTextFileStyle()),
              const SizedBox(
                height: 2.0,
              ),
              NumberEditAttribute(
                  mcontroller: quantityController,
                  hintLabel: ADD_QUANTITY,
                  limitSize: QUANTITY_LIMIT,
                  increment: () {
                    quantityController.text =
                        toString(toInt(quantityController.text) + 1);
                  },
                  decrement: () {
                    quantityController.text =
                        toString(toInt(quantityController.text) - 1);
                  },
                  validatorFunction: (value) {
                    // instead of returning the error messages here
                    // we assign the error message to the _validationError state
                    // so that we can show the error message elsewhere

                    //Regex float number [-+]?[0-9]*\.?[0-9]*
                    var resultMessage;
                    RegExp re = RegExp(INTEGER_REGULAR_EXPRESSION);

                    if (!re.hasMatch(value ?? "")) {
                      resultMessage = EDIT_ITEM_ERROR_PRICE_MSSG;
                    } else if (value is double && (value as double) < 1) {
                      resultMessage = EDIT_ITEM_ERROR_PRICE_POSITIVE_MSSG;
                    }

                    return resultMessage;
                  }),

              const SizedBox(
                height: 10.0,
              ),
              Text(ITEM_DESCRIPTION, style: semiBoldTextFileStyle()),
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
              const SizedBox(
                height: 5.0,
              ),
              Text(ITEM_CATEGORY, style: semiBoldTextFileStyle()),
              const SizedBox(
                height: 5.0,
              ),
              CustomDropdown<String>.search(
                hintText: SELECT_CATEGORY_HINT,
                items: _listCategoryName,
                initialItem: _listCategoryName[0],
                overlayHeight: 342,
                onChanged: (value) {
                  ref.read(selectedProductProvider.notifier).categories =
                      value ?? '';
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                ITEM_COLORS,
                style: semiBoldTextFileStyle(),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(ITEM_SELECT_COLORS, style: semiBoldTextFileStyle()),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 5),
                    child: ColorPicker(
                      action: (Color pikedColor) {
                        if (!selectedItem.colors
                                .any((element) => element == pikedColor) &&
                            selectedItem.colors.length + 1 <= COLORS_LIMIT) {
                          selectedItem.colors.add(pikedColor);
                          ref
                              .read(selectedProductProvider.notifier)
                              .addColor(selectedItem.colors);
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Column(
                children: [
                  // Show as part of deployment option panel
                  // Biblografy:
                  //  How to make Color Picker in Flutter?
                  //     https://www.scaler.com/topics/flutter-color-picker/
                  // BlockPicker(
                  //   pickerColor: pickerColor,
                  //   onColorChanged: changeColor,
                  // ),
                  //
                  //  Mastering Dropdowns in Flutter: A Comprehensive Guide
                  //   https://medium.com/@sobinmathew988/mastering-dropdowns-in-flutter-a-comprehensive-guide-6e76cb54fa1c
                  //
                  //

                  Row(
                      children: selectedItem.colors
                          .map((color) => GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   currentColor = index;
                                // });
                                selectedItem.colors.remove(color is Color
                                    ? color
                                    : Color(color!.value));
                                ref
                                    .read(selectedProductProvider.notifier)
                                    .addColor(selectedItem.colors);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color is Color
                                      ? color
                                      : Color(color!.value),
                                  border: Border.all(),
                                ),
                                padding: const EdgeInsets.all(2),
                                margin: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.delete_forever,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: color, shape: BoxShape.circle),
                                ),
                              )))
                          .toList()),
                ],
              ),
              const SizedBox(
                height: 5.0,
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

  Future getImageFromSources(WidgetRef ref, ImageSource source) async {
    var image = await _imagePicker.pickImage(source: source);

    try {
      selectedImage = File(image!.path);
      ref.read(selectedProductProvider.notifier).image = image!.path;
    } catch (e) {
      if (image is Null || image!.path is Null) {
        Fluttertoast.showToast(
            msg: ERROR_SELECT_IMAGE_FROM_GALLERY,
            toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  // /**
  //  *   Take Image Bibliografy
  //  *   Streamlining Image Selection with Flutter Image Picker Plugin
  //  *      https://www.dhiwise.com/post/streamlining-image-selection-with-flutter-image-picker-plugin
  //  *
  //  *   Building an image picker in Flutter
  //  *     https://blog.logrocket.com/building-an-image-picker-in-flutter/
  //  *
  //  *   Mastering Image Picking in Flutter with ImagePicker Plugin
  //  *     https://purvikrana.medium.com/mastering-image-picking-in-flutter-with-imagepicker-plugin-ee4d2429ad06
  //  *
  //  *   image_picker: ^1.1.2
  //  *      https://pub.dev/packages/image_picker/example
  //  *
  //  */
  // Widget showItemImages(WidgetRef ref) {
  //   return Column(children: [
  //     selectedImage == null
  //         ? Center(
  //             child: Material(
  //               elevation: 4.0,
  //               borderRadius: BorderRadius.circular(20),
  //               child: Container(
  //                   width: 150,
  //                   height: 140,
  //                   decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.black, width: 1.5),
  //                       borderRadius: BorderRadius.circular(20)),
  //                   child: const Icon(Icons.camera_alt_outlined,
  //                       color: Colors.black)),
  //             ),
  //           )
  //         : Center(
  //             child: Material(
  //               elevation: 4.0,
  //               borderRadius: BorderRadius.circular(10),
  //               child: Container(
  //                   width: 150,
  //                   height: 150,
  //                   decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.black, width: 1.5),
  //                       borderRadius: BorderRadius.circular(20)),
  //                   child: Column(children: [
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.circular(10),
  //                       child: selectedItem.image.contains('asset')
  //                           ? Image.asset(selectedItem.image)
  //                           : Image.file(
  //                               selectedImage!,
  //                             ),
  //                     ),
  //                   ])),
  //             ),
  //           ),
  //     const SizedBox(
  //       height: 2,
  //     ),
  //     Center(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           IconButton(
  //               color: kprimaryColor,
  //               onPressed: () => getImageFromSources(ref, ImageSource.gallery),
  //               icon: const Icon(
  //                 Icons.photo_album_outlined,
  //               )),
  //           IconButton(
  //               color: kprimaryColor,
  //               onPressed: () => getImageFromSources(ref, ImageSource.camera),
  //               icon: const Icon(
  //                 Icons.camera,
  //               )),
  //         ],
  //       ),
  //     )
  //   ]);
  // }

  updateItem(BuildContext context, WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );

      if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
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

        if (selectedItem.category.isEmpty) {
          currentSelectedCategory = DEFAULT_CATEGORY;
        }

        if (selectedItem.colors.isEmpty) {
          selectedItem.colors.add(Colors.white);
        }

        selectedItem.title = nameController.text;
        selectedItem.price = double.parse(priceController.text);
        selectedItem.category = currentSelectedCategory;
        selectedItem.description = descriptionController.text;
        selectedItem.rate = quantityController.text.toDouble() ?? 0.0;

        //Update or Add item in the list
        if (ACTION_EVENT != 'Update') {
          //selectedImage.id = addId;
          ref.read(itemSalesProvider.notifier).createProduct(selectedItem);
        } else {
          //Update on some list
          ref
              .read(itemSalesProvider.notifier)
              .updateProduct(selectedItem, indexSelectedItem);
        }

        //Go to PostSreen or Item List

        switch (fromEditScreenEvent) {
          case FilterType.updateItemList:
            if (ACTION_EVENT == 'Update') {
              ref
                  .read(itemSalesProvider.notifier)
                  .updateProduct(selectedItem, indexSelectedItem);
            }

            ref
                .read(currentIndexProvider.notifier)
                .updateCurrentMainWidget("ItemListScreen", 3);
            break;
          case FilterType.updateItemPos:
            if (ACTION_EVENT == 'Update') {
              ///UPDATE de DataBase Cart list not Database Product list
              ref
                  .read(itemSalesProvider.notifier)
                  .updateProduct(selectedItem, indexSelectedItem);

              ///UPDATE de Sales Cart list not Database Product list
              final indexInCarSales =
                  ref.watch(selectedInSalesCartProductIndexProvider);

              ref
                  .read(itemsSalesCartProvider.notifier)
                  .updateProduct(selectedItem, indexInCarSales);
            }
            ref
                .read(currentIndexProvider.notifier)
                .updateCurrentMainWidget("MainPoSScreen", 2);
            break;
          default:
            ref
                .read(currentIndexProvider.notifier)
                .updateCurrentMainWidget("Homeboard", 0);
            break;
        }
      }
    } else {
      // Display an error message if the form is not valid.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ERROR_IN_DATA)),
      );
    }
  }

  void changeColor(Color value) {
    currentPickerColor = pickerColor;
  }

  void onDismissTile() {
    if (oldDialogContext != null) {
      Navigator.of(oldDialogContext).pop();
    }
  }

  Future<String> _validateFileExists(String filePath) async {
    try {
      // Si el archivo existe, la carga será exitosa y se cargarán sus datos
      if (filePath.isEmpty || !filePath.contains('assets')) {
        throw ErrorDescription(
            "Error in file read as assets resource: $filePath");
      } else {
        AssetImage(filePath);
      }
      return filePath;
    } catch (e) {
      // Si el archivo no existe, se producirá un error
      return File(filePath).existsSync() ? filePath : NOT_FILE_ADDRESS;
    }
  }
}
