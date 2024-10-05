import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pos_inoidsoft_app/data/models/exchange_coin.dart';
import 'package:pos_inoidsoft_app/data/models/product.dart';
import 'package:pos_inoidsoft_app/presentation/providers/items_car_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/chage_currency.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/payment_method.dart';

import '../../../constant.dart';
import '../../../data/models/cart_item.dart';
import '../../providers/config_state_variables.dart';
import '../../providers/currency_coin_exchange.dart';
import '../../providers/item_sales_provider.dart';
import '../../widgets/cart_tile.dart';

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
      // foundItems = cartItems.reversed.toList();
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

  ExchangeCoin? currencyCoinExchange;

  TextEditingController resultController = TextEditingController();

  List<ExchangeCoin> currencyCoinList = [];

  String currentPaymentMethod = paymentMethod.first;

  @override
  Widget build(BuildContext context) {
    currencyCoinExchange = ref.watch(selectedCoinProvider);
    currencyCoinList = ref.watch(itemsExchangeCoinProvider);

    currencyCoinExchange = currencyCoinList
        .where((element) => element.title == currencyCoinExchange!.title)
        .toList()
        .first;
    return SafeArea(
        child: Scaffold(
            //appBar: AppBar(),
            body: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 1.80,
        color: Colors.amber.shade50,
        child: resultWidget(),
      ),
      Expanded(child: buttomWidget()),
    ])));
  }

  Widget resultWidget() {
    foundItems = ref.watch(itemsSalesCartProvider);

    calculateItems();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
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
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: SEARCH_PRODUCT),
          ),
        ),
        Expanded(
            flex: 1,
            child: foundItems.isNotEmpty
                ? ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 0),
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
                            Product(title: '', price: 0, rate: 1);

                        //Update the current quantity in cart
                        item.rate = (foundItems[index]!.quantity ?? 0) * 1.0;

                        ref.read(selectedProductProvider.notifier).product =
                            item;
                        ref
                            .read(itemSalesCurrentFilterProvider.notifier)
                            .changeCurrentFilter(FilterType.updateItemPos);
                        ref
                            .read(currentIndexProvider.notifier)
                            .updateCurrentMainWidget("ProductEditScreen", 6);

                        ref
                            .read(selectedInSalesCartProductIndexProvider
                                .notifier)
                            .updateEditSelectedItem(index);

                        ref
                            .read(selectedInSalesCartProductProvider.notifier)
                            .setProduct(foundItems[index].product ??
                                Product(title: "", price: 0.0, rate: 0.0));
                      },
                    ),
                    itemCount: foundItems.length,
                  )
                : Center(
                    child: Text(EMPTY_SEACH_RESULT,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal)),
                  )),
        Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 3),
            child: Column(
              children: [
                TextField(
                  controller: resultController,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: " ${currencyCoinExchange!.title}",
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                          decoration: TextDecoration.none)),
                ),
              ],
            )),
      ],
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
                border: Border.all(color: Colors.blueAccent),
                boxShadow: [
                  BoxShadow(
                      color:
                          const Color.fromARGB(255, 4, 0, 0).withOpacity(0.1),
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
    ref
        .read(itemSalesCurrentFilterProvider.notifier)
        .changeCurrentFilter(FilterType.all);

    switch (text) {
      case 'AC':
        //Delete option
        userInput = "";
        resultOutput = "0";
        ref.read(itemsSalesCartProvider.notifier).clearCart();
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
        ref.read(itemSalesProvider.notifier).showAll();

        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("ItemListScreen", 3);
        return;
      case '9':
        //Calculator
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("CalculatorScreen", 5);
        return;
      case '7':
        //Show window selection for diferent payment methods for chance mony price
        //MLC, USD, EURO, CUP

        if (foundItems.isNotEmpty) {
          ref
              .read(selectedCoinProvider.notifier)
              .setCoin(currencyCoinList.first);

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                oldDialogContext = dialogContext;

                return ChangeCurremcyDialog(
                  title: TITLE_CHANGE_COIN,
                  content: '',
                  actions: <Widget>[
                    SizedBox(
                        height: 120,
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButton(
                                borderRadius: BorderRadius.circular(20)
                                    .copyWith(topLeft: Radius.circular(0)),
                                isExpanded: true,
                                hint: Text(TYPE_EXCHANGE,
                                    style: const TextStyle(fontSize: 15)),
                                value: currencyCoinExchange,
                                items: currencyCoinList
                                    .map((element) => DropdownMenuItem(
                                        value: element,
                                        child: Text(element.title,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black45))))
                                    .toList(),
                                onChanged: (val) {
                                  //print('SearchDropdown onChanged value: $val');
                                  final changeCurrency = val as ExchangeCoin;

                                  ref
                                      .read(selectedCoinProvider.notifier)
                                      .setCoin(changeCurrency);

                                  ref
                                      .read(currentExchangeCoinSourceProvider
                                          .notifier)
                                      .updateShoppingCartSize(
                                          changeCurrency!.title);
                                  setState(() {});
                                  onDismiss();
                                }),
                            SizedBox(
                              width: 180,
                              child: FloatingActionButton(
                                onPressed: onDismiss,
                                backgroundColor: Colors.grey,
                                child: Text(
                                  CANCEL_ACTION,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              });
        }
        break;
      case '+':
        //Payment
        //Show window selection for diferent payment methods using Transfermovil, EnZone
        //Pay in chash, dual (Payment gateway and cash)
        if (foundItems.isNotEmpty) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                oldDialogContext = dialogContext;
                return PaymentMethodDialog(
                  title: TITLE_PAYMENT_METHOD,
                  content: '',
                  actions: <Widget>[
                    DropdownButton(
                        borderRadius: BorderRadius.circular(20)
                            .copyWith(topLeft: const Radius.circular(0)),
                        isExpanded: true,
                        hint: Text(TYPE_EXCHANGE,
                            style: const TextStyle(fontSize: 15)),
                        value: currentPaymentMethod,
                        items: paymentMethod
                            .map((element) => DropdownMenuItem(
                                value: element,
                                child: Text(element,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black45))))
                            .toList(),
                        onChanged: (val) {
                          //print('SearchDropdown onChanged value: $val');
                          final seletedPaymentMethod = val as String;
                          setState(() {
                            currentPaymentMethod = seletedPaymentMethod;

                            ref
                                .read(paymentMethodProvider.notifier)
                                .setPayment(seletedPaymentMethod);

                            ref
                                .read(stadisticsSalesCartProvider.notifier)
                                .addSalesCart(foundItems);

                            ref
                                .read(itemsSalesCartProvider.notifier)
                                .clearCart();
                          });

                          //Save as Sales Stadistics

                          ///Clean the current in Sales Invoce when was saved

                          ref
                              .read(currentIndexProvider.notifier)
                              .updateCurrentMainWidget("SalesInvoice", 10);
                          onDismiss();
                        }),
                    SizedBox(
                      height: 60,
                      width: 180,
                      child: FloatingActionButton(
                        onPressed: onDismissPayment,
                        child: Text(
                          CANCEL_ACTION,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                );
              });
        }

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
      resultOutput = (total * currencyCoinExchange!.rate).toStringAsFixed(2);
      resultController.text = "\$ $resultOutput";
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
  }

  onDismissPayment() {
    if (oldDialogContext != null) {
      Navigator.of(oldDialogContext).pop();
    }
    //oldDialogContext = null;
  }
}
