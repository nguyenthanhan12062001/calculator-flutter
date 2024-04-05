import 'package:calc_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Máy tính',
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorApp();
}

class _CalculatorApp extends State<CalculatorApp> {
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outPutSize = 34.0;

  void onButtonClick(String value) {
    if (value == "AC") {
      clear();
    } else if (value == "<") {
      backspace();
    } else if (value == "=") {
      calculate();
    } else {
      appendInput(value);
    }
  }

  void clear() {
    setState(() {
      input = '';
      output = '';
    });
  }

  void backspace() {
    if (input.isNotEmpty) {
      setState(() {
        input = input.substring(0, input.length - 1);
      });
    }
  }

  void calculate() {
    if (input.isNotEmpty) {
      var userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      setState(() {
        output = finalValue.toString();

        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
      });
    }
  }

  void appendInput(String value) {
    setState(() {
      input += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thành An",
          style: TextStyle(
            color: Colors.amber,
          ),
          
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            // color: Colors.yellow[600],

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
          Row(
            children: [
              button(
                text: "AC",
                buttonBgColor: orangeColor,
              ),
              button(
                text: "<",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
              button(
                text: "+/-",
                buttonBgColor: Colors.transparent,
              ),
              button(
                text: "/",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                text: "x",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                text: "-",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                text: "+",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "%"),
              button(text: "0"),
              button(text: "."),
              button(
                text: "=",
                buttonBgColor: orangeColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 200, 198, 198)
                  .withOpacity(0.5), // Màu của bóng đổ
              spreadRadius: 3, // Độ lan rộng của bóng đổ
              blurRadius: 7, // Độ mờ của bóng đổ
              offset: const Offset(
                  5, 3), // Độ dịch chuyển của bóng đổ theo trục X và Y
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22),
            backgroundColor: buttonBgColor,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
