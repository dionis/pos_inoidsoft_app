import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pos_inoidsoft_app/constant.dart';

import '../domain/qr_code_reader_windows.dart';
import '../models/cart_item.dart';

class HomePosScreen extends StatefulWidget {
  const HomePosScreen({super.key});

  @override
  State<HomePosScreen> createState() => _HomePosScreenState();
}

class _HomePosScreenState extends State<HomePosScreen> {
  String userInput = "0";
  String resultOutput = "0";

  // List<String> buttonList = [
  //   "AC",
  //   "(",
  //   ")",
  //   "/",
  //   "7",
  //   "8",
  //   "9",
  //   "+",
  //   "4",
  //   "5",
  //   "6",
  //   "*",
  //   "1",
  //   "2",
  //   "3",
  //   "-",
  //   "C",
  //   "0",
  //   ".",
  //   "="
  // ];

  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "+",
    "4",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //appBar: AppBar(),
            body: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 2.90,
        child: resultWidget(),
      ),
      // const SizedBox(
      //   width: 5,
      // ),
      Expanded(child: buttomWidget())
    ])));
  }

  Widget resultWidget() {
    calculateItems();

    return Container(
      color: Colors.amber.shade50,
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) => CarTile(
              item: cartItems[index],
              onRemove: () {
                setState(() {
                  if (cartItems[index] != 1) {
                    cartItems[index].quantity--;
                  }
                });
              },
              onAdd: () {
                setState(() {
                  cartItems[index].quantity++;
                });
              },
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: cartItems.length,
          ),
          const SizedBox(height: 5),
          Expanded(
              child: Text(
            resultOutput,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
            textDirection: TextDirection.rtl,
          )),
          //Container(
          //   padding: const EdgeInsets.all(20),
          //   alignment: Alignment.bottomRight,
          //   child: Text(resultOutput,
          //       style:
          //           const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          // )
        ],
      ),

      //  Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     //Search input for filter buyer in a car
      //     //ListView with all Product with filter
      //     // Container(
      //     //   padding: const EdgeInsets.all(20),
      //     //   alignment: Alignment.bottomRight,
      //     //   child: Text(userInput,
      //     //       style:
      //     //           const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
      //     // ),

      //     //const SizedBox(height: 5),
      //     // Container(
      //     //   padding: const EdgeInsets.all(20),
      //     //   alignment: Alignment.bottomRight,
      //     //   child: Text(resultOutput,
      //     //       style:
      //     //           const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
      //     // )
      //   ],
      // ),
    );
  }

  buttomWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(66, 233, 232, 232),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: buttonList.length,
          itemBuilder: (context, index) {
            return showButton(buttonList[index]);
          }),
    );
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
        return Colors.redAccent;
      case "=":
      case "AC":
        return Colors.white;
      default:
        return Colors.blue;
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
                borderRadius: BorderRadius.circular(10),
                color: getColor(text),
                image: getImageButtonDecoration(text),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 1,
                      spreadRadius: 1)
                ]),
            child: Center(
                child: Text(text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)))));
  }

  handleButtonPress(String text) {
    //Continue on https://youtu.be/Yc9U62-Tr-0?list=PLvG2mD7Ba5Sw0TKZwIW_7nNbihTRc8VN4&t=948
    if (text == 'AC') {
      userInput = "";
      resultOutput = "0";
      return;
    } else if (text == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    } else if (text == '=') {
      resultOutput = calculate();

      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }

      if (resultOutput.endsWith(".0")) {
        resultOutput = resultOutput.replaceAll(".0", "");
      }

      return;
    } else if (text == '(') {
      Navigator.of(context).push(
        MaterialPageRoute(
          //QR Reader see mor examples in:
          //https://github.com/juliansteenbakker/mobile_scanner/blob/master/example/lib/

          //and about the library
          // https://pub.dev/packages/mobile_scanner/

          builder: (context) => const QrReaderCodeWindow(),
        ),
      );

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
    try {
      double total = cartItems.fold(0,
          (tot, item) => tot.toDouble() + item.product.price * item.quantity);
      resultOutput = "\$ ${total.toString()}";
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
}

//Bibliografy
// https://youtu.be/44OUQU3oKPI?list=PL9XXql9aWnAao5hF3mG0XEqFEhxZzIIVb&t=728
// https://www.youtube.com/watch?v=ZVcAa2uuksk&list=PL5jb9EteFAOA3tCKoanOSEJaIDYn1Z5LC&index=16

class CarTile extends StatelessWidget {
  CartItem item;
  Function() onAdd;
  Function() onRemove;

  CarTile(
      {super.key,
      required this.item,
      required this.onAdd,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  child: Image.asset(item.product.image),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.product.category,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(189, 189, 189, 1)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$${item.product.price}",
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.trash_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
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
                      const SizedBox(width: 5),
                      Text("${item.quantity}"),
                      const SizedBox(width: 5),
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
                )
              ],
            ))
      ],
    );
  }
}
