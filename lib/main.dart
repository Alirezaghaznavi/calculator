import 'package:calculator/constansts.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var result = '';
  var inputUser = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundGrey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Claculator',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: textGreen),
                        ),
                      ),
                      buildPadding(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 13,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getRow('ac', 'ce', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        result,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 33,
          fontWeight: FontWeight.bold,
          color: textGrey,
        ),
      ),
    );
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
            backgroundColor: getBackgoundColor(text1),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Center(
              child: Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  color: getTextColor(text1),
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
            backgroundColor: getBackgoundColor(text2),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextColor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            buttonPressed(text3);
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
            backgroundColor: getBackgoundColor(text3),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextColor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text4 == '=') {
              Parser paser = Parser();
              Expression expression = paser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
            backgroundColor: getBackgoundColor(text4),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextColor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isOprator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];

    for (var element in list) {
      if (text == element) {
        return true;
      }
    }
    return false;
  }

  Color getBackgoundColor(String text) {
    if (isOprator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOprator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
