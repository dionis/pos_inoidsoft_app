import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pos_inoidsoft_app/constant.dart';
import 'package:pos_inoidsoft_app/data/models/product.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/chage_currency.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/payment_method.dart';

import 'Qrcode_reader/qr_code_reader_windows.dart';
import '../../data/models/cart_item.dart';
import '../providers/config_state_variables.dart';
import '../providers/item_sales_provider.dart';
import '../widgets/cart_tile.dart';

class HomePosScreen extends ConsumerStatefulWidget {
  const HomePosScreen({super.key});

  @override
  ConsumerState<HomePosScreen> createState() => _HomePosScreenState();
}

class _HomePosScreenState extends ConsumerState<HomePosScreen> {
  String userInput = "0";
  String resultOutput = "0";

  List<CartItem> foundItems = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      foundItems = cartItems.reversed.toList();
    });
  }

  List<String> buttonList = [
    "AC",
    "(",
    "7",
    ")",
    "/",
    "8",
    "9",
    "+",
  ];

  get SEARCH_PRODUCT => "Buscar producto";

  String get EMPTY_SEACH_RESULT => "No se encontraron productos";

  late BuildContext oldDialogContext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //appBar: AppBar(),
            body: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 1.80,
        child: resultWidget(),
      ),
      Expanded(child: buttomWidget()),
    ])));
  }

  Widget resultWidget() {
    calculateItems();

    return Container(
      color: Colors.amber.shade50,
      // child: SingleChildScrollView(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          //  Expanded(
          Flexible(
              flex: 1,
              child: Container(
                child: TextField(
                  onChanged: (value) => _onSearchInItems(value),
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),
                      fillColor: const Color.fromRGBO(228, 224, 224, 1),
                      contentPadding: const EdgeInsets.all(0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      hintText: SEARCH_PRODUCT),
                ),
              )),
          // child:
          Flexible(
            flex: 4,
            child: foundItems.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) => CarTile(
                      item: foundItems[index],
                      onRemove: () {
                        setState(() {
                          if (foundItems[index].quantity != 1) {
                            foundItems[index].quantity--;
                          }
                        });
                      },
                      onAdd: () {
                        setState(() {
                          foundItems[index].quantity++;
                        });
                      },
                      onDeleteItem: () {
                        setState(() {
                          cartItems.removeAt(index);
                          foundItems.removeAt(index);
                          ref
                              .read(shoppinCartSizeProvider.notifier)
                              .updateShoppingCartSize(cartItems.length);
                        });
                      },
                      onEditItem: () {
                        final item = foundItems[index]?.product ??
                            Product(title: '', price: 0, rate: 0);
                        ref
                            .read(selectedProductProvider.notifier)
                            .setProduct(item);
                        ref
                            .read(currentIndexProvider.notifier)
                            .updateCurrentMainWidget("ProductEditScreen", 6);
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount: foundItems.length,
                  )
                : Center(
                    child: Text(EMPTY_SEACH_RESULT,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal)),
                  ),
          ),
          //),
          const SizedBox(height: 5),
          Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("\$ ",
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl),
                  Text(
                    resultOutput,
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  buttomWidget() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: buttonList.length,
        itemBuilder: (context, index) {
          return showButton(buttonList[index]);
        });
  }

  getColor(String text) {
    switch (text) {
      case "(":
        return const Color.fromARGB(255, 255, 68, 158);
      case "/":
      case "*":
      case "+":
      case "-":
      case "C":
      case ")":
        return Colors.white;
      case "=":
      case "AC":
        return Colors.white;
      case "4":
        return Colors.grey.shade200;
      default:
        return Colors.white;
    }
  }

  getBgColor(String text) {
    switch (text) {
      case "/":
      case "*":
      case "+":
      case "-":
      case "C":
      case ")":
      case "(":
        return Colors.redAccent;
      case "=":
      case "AC":
        return const Color.fromARGB(255, 104, 204, 159);
      default:
        return Colors.white;
    }
  }

  Widget showButton(String text) {
    return InkWell(
        onTap: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: getColor(text),
                image: getImageButtonDecoration(text),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 1,
                      spreadRadius: 1)
                ]),
            child: const Center(
                child: Text('',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)))));
  }

  handleButtonPress(String text) {
    //Continue on https://youtu.be/Yc9U62-Tr-0?list=PLvG2mD7Ba5Sw0TKZwIW_7nNbihTRc8VN4&t=948

    switch (text) {
      case 'AC':
        //Delete option
        userInput = "";
        resultOutput = "0";
        return;
      case 'C':
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
          return;
        } else {
          return null;
        }
      case '=':
        resultOutput = calculate();

        if (userInput.endsWith(".0")) {
          userInput = userInput.replaceAll(".0", "");
        }

        if (resultOutput.endsWith(".0")) {
          resultOutput = resultOutput.replaceAll(".0", "");
        }

        return;
      case '(':
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("QrReaderCodeWindow", 1);
        return;
      case '/':
        //Item list
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("ItemListScreen", 3);
        return;
      case '9':
        //Calculator
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("Calculator", 5);
        return;
      case '7':
        //Show window selection for diferent payment methods for chance mony price
        //MLC, USD, EURO, CUP
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              oldDialogContext = dialogContext;
              return ChangeCurremcyDialog(
                title: 'Title Change Currency',
                content: 'Dialog content',
                actions: <Widget>[
                  Container(
                    height: 60,
                    width: 180,
                    child: FloatingActionButton(
                      onPressed: onDismiss,
                      child: const Text('Dismiss dialog'),
                    ),
                  ),
                ],
              );
            });

        break;
      case '+':
        //Payment
        //Show window selection for diferent payment methods using Transfermovil, EnZone
        //Pay in chash, dual (Payment gateway and cash)
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              oldDialogContext = dialogContext;
              return PaymentMethodDialog(
                title: 'Title Payment Method',
                content: 'Dialog content',
                actions: <Widget>[
                  Container(
                    height: 60,
                    width: 180,
                    child: FloatingActionButton(
                      onPressed: onDismiss,
                      child: const Text('Dismiss dialog'),
                    ),
                  ),
                ],
              );
            });

        break;
      case '8':
        //Home
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("Homeboard", 0);

        return;
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      Expression expr = Parser().parse(userInput);
      var evaluation = expr.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }

  String calculateItems() {
    //Bibliografy: How to show different Currency symbols in flutter
    //    - https://medium.com/@komolafeezekieldare/step-by-step-in-how-to-display-currency-symbols-like-or-k%C4%8D-in-flutter-ad708a802c49
    //
    //  How to use Flexible and Expanded Widget in Flutter
    //   - https://medium.com/@ramantank04/exploring-flutter-layout-widgets-expanded-and-flexible-e384b351815
    //

    try {
      double total = foundItems.fold(
          0,
          (tot, item) =>
              tot.toDouble() + (item.product?.price ?? 1) * item.quantity);
      resultOutput = total.toStringAsFixed(2);
      return resultOutput;
    } catch (e) {
      return 'Error';
    }
  }

  getImageButtonDecoration(String text) {
    switch (text) {
      case '(':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/qr-code-strong.png"));

      case '7':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/change.png"));

      case '+':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/payment-method.png"));
      case 'AC':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/trash.png"));
      case '9':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/calculator.png"));
      case ')':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/back.png"));
      case '/':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/report.png"));
      case '8':
        return const DecorationImage(
            image: AssetImage("images/pos_calculator/home.png"));
      default:
        return null;
    }
  }

  _onSearchInItems(String value) {
    setState(() {
      if (value.isEmpty) {
        foundItems = cartItems;
      } else {
        foundItems = cartItems
            .where((items) => (items.product?.title ?? "")
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  onDismiss() {
    if (oldDialogContext != null) {
      Navigator.of(oldDialogContext).pop();
    }
    //oldDialogContext = null;
  }
}
