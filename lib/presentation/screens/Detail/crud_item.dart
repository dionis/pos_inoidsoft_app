import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Qrcode_reader/qr_code_reader_windows.dart';
import 'package:random_name_generator/random_name_generator.dart';
import 'package:uuid/uuid.dart';

import '../../../constant.dart';
import '../../../data/models/product.dart';

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

  String ACTION_BUTTON = 'Add';

  String? itemCategory = '';

  List<String> categoryList =
      List<String>.generate(5, (int i) => RandomNames(Zone.spain).fullName());

  late Product selectedItem;

  String ITEM_CATEGORY = "Categorías:";

  String UPDATE_IMAGE = "Actualizar imagen:";

  Color updateColorEvent = Colors.black;

  String ITEM_BARCODE_OR_QR = 'Código de barras / QR';

  String BARCODE_OR_QR_TEXT = "Código asociado";

  int currentColor = 0;

  Color pickerColor = Color(0xff443a49);
  Color currentPickerColor = Color(0xff443a49);

  String ITEM_QUANTITY = 'Cantidad';

  String ADD_QUANTITY = "Añadir cantidad";

  CrudItemScreen({super.key, required this.eventTitle}) {
    CRUD_ITEM_TITLE =
        eventTitle == ADD_PRODUCT ? 'Agregar Producto' : 'Editar Producto';
    ACTION_BUTTON = eventTitle == ADD_PRODUCT ? 'Agregar' : 'Actualizar';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    selectedItem = ref.watch(selectedProductProvider);

    if (selectedItem != null) {
      selectedImage = File(
          (selectedItem.image == null || selectedItem.image == '')
              ? "assets/no-image.jpg"
              : selectedItem.image);

      CRUD_ITEM_TITLE =
          selectedItem.title == '' ? 'Agregar Producto' : 'Editar Producto';
      ACTION_BUTTON = selectedItem.title == '' ? 'Agregar' : 'Actualizar';
    }

    nameController.text = selectedItem.title;
    priceController.text = selectedItem.price.toString();
    descriptionController.text = selectedItem.description.substring(0, 50);
    barCodeOrQrController.text = selectedItem.barcode;
    quantityController.text = selectedItem.rate.toString();

    BARCODE_OR_QR_TEXT = selectedItem.barcode;

    itemCategory = categoryList.elementAt(2);

    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  updateItem();
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
      body: SingleChildScrollView(
        // margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(UPDATE_IMAGE,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(
              height: 2.0,
            ),
            showItemImages(),
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
              child: TextField(
                readOnly: true,
                controller: barCodeOrQrController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: () {},
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
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ADD_ITEN_NAME,
                    hintStyle: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w300)),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ADD_PRICE,
                    hintStyle: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w300)),
              ),
            ),
            //Add or update Detail
            const SizedBox(
              height: 10.0,
            ),
            Text(ITEM_QUANTITY, style: semiBoldTextFileStyle()),
            const SizedBox(
              height: 2.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: quantityController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ADD_QUANTITY,
                    hintStyle: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w300)),
              ),
            ),
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
              child: TextField(
                maxLines: 3,
                controller: descriptionController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ADD_DESCRIPTION,
                    hintStyle: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w300)),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(ITEM_CATEGORY, style: semiBoldTextFileStyle()),
            const SizedBox(
              height: 5.0,
            ),
            Center(
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                items: categoryList
                    .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.black),
                        )))
                    .toList(),
                onChanged: ((value) => itemCategory = value),
                dropdownColor: Colors.white,
                hint: const Text("Select Category"),
                iconSize: 36,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                value: itemCategory,
              )),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Color: ",
              style: semiBoldTextFileStyle(),
            ),
            const SizedBox(
              height: 5,
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
                Row(
                  children: List.generate(
                      selectedItem.colors.length,
                      (index) => GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   currentColor = index;
                            // });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentColor == index
                                  ? Colors.white
                                  : selectedItem.colors[index],
                              border:
                                  currentColor == index ? Border.all() : null,
                            ),
                            padding: currentColor == index
                                ? const EdgeInsets.all(2)
                                : null,
                            margin: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: selectedItem.colors[index],
                                  shape: BoxShape.circle),
                            ),
                          ))),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                updateColorEvent = Colors.grey;
                updateItem();
              },
              child: Center(
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                        color: updateColorEvent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(ACTION_BUTTON,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle semiBoldTextFileStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  }

  Future getImage() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
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

  updateItem() {
    if (selectedImage != null &&
        nameController.text.isNotEmpty &&
        itemCategory!.isNotEmpty &&
        priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
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
    }
  }

  void changeColor(Color value) {
    currentPickerColor = pickerColor;
  }
}
