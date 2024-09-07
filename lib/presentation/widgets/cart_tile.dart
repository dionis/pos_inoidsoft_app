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

class CarTile extends ConsumerWidget {
  CartItem item;
  Function() onAdd;
  Function() onRemove;
  Function() onDeleteItem;
  Function() onEditItem;

  late BuildContext oldDialogContextTile;
  String EDIT_ITEM_TITLE = 'Actualizar';
  String DELETE_ITEM_TITLE = 'Eliminar';

  String DELETE_ITEM_MESSAGE = '¿ Desea elimiar este producto ?';
  String EDIT_ITEM_MESSAGE = '¿ Desea actualizar este producto ?';

  String CANCEL_BUTTON_LABEL = 'Cancelar';
  String DELETE_BUTTON_LABEL = 'Eliminar';
  String UPDATE_BUTTON_LABEL = 'Actualizar';

  CarTile(
      {super.key,
      required this.item,
      required this.onAdd,
      required this.onRemove,
      required this.onDeleteItem,
      required this.onEditItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    child: Image.asset(validateItemImage(item.product)),
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
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    decoration: BoxDecoration(
                        color: kcontentColor,
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: onRemove,
                          icon: const Icon(
                            Ionicons.remove_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text("${item.quantity}"),
                        const SizedBox(width: 2),
                        IconButton(
                          onPressed: onAdd,
                          icon: const Icon(
                            Ionicons.add_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
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
                                              child: Text(CANCEL_BUTTON_LABEL),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 110,
                                            child: FloatingActionButton(
                                              onPressed: onEditTile,
                                              child: Text(UPDATE_BUTTON_LABEL),
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
                            size: 25,
                          ),
                        ),
                        IconButton(
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
    return product == null || product.image == ''
        ? "assets/no-image.jpg"
        : product.image;
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

  void onAcceptDeleteTile() {
    onDeleteItem();

    if (oldDialogContextTile != null) {
      Navigator.of(oldDialogContextTile).pop();
    }

    // CartItem existItemInCart;

    // try {
    //   existItemInCart = cartItems.firstWhere(
    //       (element) => element?.product?.title == item.product?.title,
    //       orElse: () => CartItem(quantity: 1, product: null));
    // } catch (e) {
    //   existItemInCart = CartItem(quantity: 1, product: null);
    // }
  }
}
