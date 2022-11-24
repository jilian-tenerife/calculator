import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "Del") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 150,
              color: Color(0xffe5989b),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style:
                    TextStyle(fontSize: equationFontSize, color: Colors.white),
              ),
            ),
            Container(
              height: 231,
              color: Color(0xffb5838d),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: Colors.white),
              ),
            ),
            Expanded(
              child: Divider(
                color: Color(0xfff9ec9ef),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", 1, Color(0xff6d6875)),
                        buildButton("Del", 1, Color(0xffffb4a2)),
                        buildButton("÷", 1, Color(0xffffb4a2)),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Color(0xffffcdb2)),
                        buildButton("8", 1, Color(0xffffcdb2)),
                        buildButton("9", 1, Color(0xffffcdb2)),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Color(0xffffcdb2)),
                        buildButton("5", 1, Color(0xffffcdb2)),
                        buildButton("6", 1, Color(0xffffcdb2)),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Color(0xffffcdb2)),
                        buildButton("2", 1, Color(0xffffcdb2)),
                        buildButton("3", 1, Color(0xffffcdb2)),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Color(0xffffcdb2)),
                        buildButton("0", 1, Color(0xffffcdb2)),
                        buildButton("00", 1, Color(0xffffcdb2)),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("×", 1, Color(0xffffb4a2)),
                      ]),
                      TableRow(children: [
                        buildButton("-", 1, Color(0xffffb4a2)),
                      ]),
                      TableRow(children: [
                        buildButton("+", 1, Color(0xffffb4a2)),
                      ]),
                      TableRow(children: [
                        buildButton("=", 2, Color(0xff6d6875)),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
