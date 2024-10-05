import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../constant.dart';
import '../../data/models/cart_item.dart';
import '../../data/models/product.dart';
import 'chage_currency.dart';

//Bibliografy
// https://youtu.be/44OUQU3oKPI?list=PL9XXql9aWnAao5hF3mG0XEqFEhxZzIIVb&t=728
// https://www.youtube.com/watch?v=ZVcAa2uuksk&list=PL5jb9EteFAOA3tCKoanOSEJaIDYn1Z5LC&index=16

class CarTileStore extends ConsumerWidget {
  CartItem item;
  Function() onAdd;
  Function() onRemove;
  Function() onDeleteItem;
  Function() onEditItem;
  Function() onAddInCartSales;

  late BuildContext oldDialogContextTile;
  String EDIT_ITEM_TITLE = 'Actualizar';
  String DELETE_ITEM_TITLE = 'Eliminar';

  String DELETE_ITEM_MESSAGE = '¿ Desea elimiar este producto ?';
  String EDIT_ITEM_MESSAGE = '¿ Desea actualizar este producto ?';

  String CANCEL_BUTTON_LABEL = 'Cancelar';
  String DELETE_BUTTON_LABEL = 'Eliminar';
  String UPDATE_BUTTON_LABEL = 'Actualizar';

  CarTileStore(
      {super.key,
      required this.item,
      required this.onAdd,
      required this.onRemove,
      required this.onDeleteItem,
      required this.onEditItem,
      required this.onAddInCartSales});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String imageToShoPath = validateItemImage(item.product);

    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Stack(
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                        color: kcontentColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: imageToShoPath.contains('assets')
                        ? Image?.asset(imageToShoPath!, fit: BoxFit.cover)
                        : Image.file(File(imageToShoPath!), fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (item.product?.title ?? "").length < 15
                            ? item.product?.title ?? ""
                            : (item.product?.title ?? "").substring(0, 15),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.product?.category ?? "",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(189, 189, 189, 1)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$${item.product?.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Positioned(
              top: 5,
              right: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton.outlined(
                            onPressed: addToCart,
                            icon: Icon(
                              Icons.shopping_cart_checkout_rounded,
                              color: Colors.greenAccent.shade700,
                              size: 20,
                            )),
                        IconButton.outlined(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext dialogContext) {
                                  oldDialogContextTile = dialogContext;

                                  return ChangeCurremcyDialog(
                                    title: EDIT_ITEM_TITLE,
                                    content: EDIT_ITEM_MESSAGE,
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 110,
                                            child: FloatingActionButton(
                                              onPressed: onDismissTile,
                                              child: Text(CANCEL_BUTTON_LABEL,
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 110,
                                            child: FloatingActionButton(
                                              onPressed: onEditTile,
                                              child: Text(UPDATE_BUTTON_LABEL,
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Ionicons.pencil_sharp,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                        ),
                        IconButton.outlined(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext dialogContext) {
                                  oldDialogContextTile = dialogContext;

                                  return ChangeCurremcyDialog(
                                    title: DELETE_ITEM_TITLE,
                                    content: DELETE_ITEM_MESSAGE,
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 110,
                                            child: FloatingActionButton(
                                              onPressed: onDismissTile,
                                              child: Text(CANCEL_BUTTON_LABEL),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 110,
                                            child: FloatingActionButton(
                                              onPressed: onAcceptDeleteTile,
                                              child: Text(DELETE_BUTTON_LABEL),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Ionicons.trash_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ])
                ],
              ))
        ],
      ),
    );
  }

  String validateItemImage(Product? product) {
    String result = NOT_FILE_ADDRESS;

    result = _validateFileExists(product!.image);

    return (product == null || product.image == '') ? NOT_FILE_ADDRESS : result;
  }

  void onDismissTile() {
    if (oldDialogContextTile != null) {
      Navigator.of(oldDialogContextTile).pop();
    }
  }

  void onEditTile() {
    onEditItem();

    if (oldDialogContextTile != null) {
      Navigator.of(oldDialogContextTile).pop();
    }
  }

  void addToCart() {
    onAddInCartSales();
  }

  void onAcceptDeleteTile() {
    onDeleteItem();

    if (oldDialogContextTile != null) {
      Navigator.of(oldDialogContextTile).pop();
    }
  }

  String _validateFileExists(String filePath) {
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
