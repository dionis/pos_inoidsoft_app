import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String userInput = "0";
  String resultOutput = "0";

  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "*",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 2.90,
        child: resultWidget(),
      ),
      Expanded(child: buttomWidget())
    ])));
  }

  Widget resultWidget() {
    return Container(
      color: Colors.amber.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Text(userInput,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Text(resultOutput,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  buttomWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(66, 233, 232, 232),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
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
}
