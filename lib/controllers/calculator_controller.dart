import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  String userInput ="";
  String result ="0";
//±
  List<String> buttonList=[
    'AC',
    '+/-',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  Color getColor(String text){
    if (text == "÷" ||
        text == "x" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "." ||
        text == "+/-" ||
        text == "%") {
      return const Color.fromARGB(255, 194, 137, 137);
    }
    return Colors.white;
  }

  Color getBgColor(String text){
    if (text == "AC") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return const Color.fromARGB(255, 19, 188, 112);
    }
    return const Color(0xFF1d2630);
  }

  void handleButtons(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      update();
      return;
    }
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0, userInput.length -1);
        update();
        return;
      }
      else{
        return;
      }
    }
    if(text == "="){
      try {
        var exp = Parser().parse(userInput);
        var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
        var result = double.parse(evaluation.toString());

        if (result % 1 == 0) {
          this.result = result.toInt().toString();
        } else {
          this.result = result.toStringAsFixed(2);
        }
      } catch (e) {
        result = "Hata";
      }

      userInput = result;
      update();
      return;
    }

    if(text == "+/-"){
      if(userInput.startsWith("-")) {
        userInput = userInput.substring(1);
      } else {
        userInput = "-$userInput";
      }
      update();
      return;
    }

    if(text == "%"){
      try {
        var exp = Parser().parse(userInput);
        var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
        var result = double.parse(evaluation.toString()) / 100;
        userInput = result.toString();
        update();
        return;
      } catch (e) {
        result = "Hata";
      }
    }

    if(text == "x"){
      text = "*";
    }

    if(text == "÷"){
      text = "/";
    }

    if(text == "+/-"){
      text = "±";
    }

    userInput = userInput + text;
    update();
  }
}
