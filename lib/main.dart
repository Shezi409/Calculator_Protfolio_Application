import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'colors.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
// variables declear

  double fNum = 0.0;
  double sNum = 0.0;
  var input = '';
  var output = '';
  var operations = '';
  var hideInput = false;
  var outputSize = 34.0;

  onClickButton(value) {
    print(value);
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 56;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? "" : input, // variable
                    style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output, // variable
                    style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            )),
            Row(
              children: [
                buttons(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor,
                ),
                buttons(
                    text: "<",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
                buttons(
                    text: "~",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
                buttons(
                    text: "/",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                buttons(text: "7"),
                buttons(text: "8"),
                buttons(text: "9"),
                buttons(
                    text: "x",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                buttons(text: "4"),
                buttons(text: "5"),
                buttons(text: "6"),
                buttons(
                    text: "-",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                buttons(text: "1"),
                buttons(text: "2"),
                buttons(text: "3"),
                buttons(
                    text: "+",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                buttons(
                    text: "%",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
                buttons(text: "0"),
                buttons(
                    text: ".",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor),
                buttons(text: "=", buttonBgColor: orangeColor),
              ],
            ),
          ],
        ));
  }

  Widget buttons({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(22),
                    backgroundColor: buttonBgColor),
                onPressed: () => onClickButton(text),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: tColor,
                    fontWeight: FontWeight.bold,
                  ),
                ))));
  }
}
