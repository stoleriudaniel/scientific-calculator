import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scientific Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ScientificCalculator(),

    );
  }
}

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({Key? key}) : super(key: key);

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {

  String equation = "0";//"2+3x4+5x(1+3x5+4x2)";
  String result = "";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  bool rad = true;
  bool deg = false;
  var infixExpList = ['0'];//['2', '+', '3', 'x', '4', '+', '5', 'x', '(', '1', '+', '3', 'x', '5', '+', '4', 'x', '2', ')'];
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  int prec(String op)
  {
    if(op == "@")
      return 5;
    else if (op == "^")
      return 4;
    else if(op=="%")
      return 3;
    else if (op == "÷" || op == "x")
      return 2;
    else if (op == "+" || op == "-")
      return 1;
    else
      return -1;
  }

  dynamic getPostfix(var infixList){
    var postfixExpList = [];
    var stack = [];
    for(int index=0; index < infixList.length; index++){
      var element = infixList[index];
      if(isNumeric(element) || element=="sin" || element=="cos" || element=="tan" ||
        element == "√" || element == "lg" || element == "ln"){
        postfixExpList.add(element);
      }
      else if(element == "(")
        stack.add("(");
      else if(element == ")"){
        while(stack.last != "("){
          postfixExpList.add(stack.last);
          stack.removeLast();
        }
        stack.removeLast();
      }
      else { // operator
        while(!stack.isEmpty && prec(element) <= prec(stack.last)){
          if(element == "^" && stack.last == "^")
            break;
          else{
            postfixExpList.add(stack.last);
            stack.removeLast();
          }
        }
        stack.add(element);
      }
    }
    while(!stack.isEmpty){
      postfixExpList.add(stack.last);
      stack.removeLast();
    }
    print("postfi:"); print(postfixExpList);
    return postfixExpList;
  }

  bool isDouble(String str){
    for(int i=0; i<str.length; i++){
      if(str[i]=='.'){
        return true;
      }
    }
    return false;
  }

  bool isTrigonometric(String str){
    if(str == "sin") return true;
    if(str == "cos") return true;
    if(str == "tan") return true;
    if(str == "lg") return true;
    if(str == "ln") return true;
    return false;
  }

  dynamic evaluatePostfix(var postfixExp){
    dynamic rezultat = 0.0;
    for(int index=0; index<postfixExp.length-2; index++){
      dynamic a = postfixExp[index];
      dynamic b = postfixExp[index+1];
      dynamic op = postfixExp[index+2];
      print("----postfixExpppp=="); print(postfixExp);
      if(isNumeric(a) && isNumeric(b) && prec(op)>=1 && prec(op)<5){
        dynamic r;
        if(isDouble(a)){
          a = double.parse(a);
        }
        else a = int.parse(a);
        if(isDouble(b)){
          b = double.parse(b);
        }
        else b = int.parse(b);
        if(op == "+") {
          r = a + b;
        }
        else if(op == "-")
          r = a - b;
        else if(op == "x")
          r = a * b;
        else if(op == "÷")
          r = a / b;
        else if(op == "%")
          r = a % b;
        else if(op == "^")
          r = pow(a, b);
        rezultat = r;
        postfixExp.removeAt(index);
        postfixExp.removeAt(index);
        postfixExp.removeAt(index);
        postfixExp.insert(index, r.toString());
        index=-1;
        print("---rezultat=");
        print(rezultat);
      }
      else if((isTrigonometric(a) || a == "√") && isNumeric(b) && op=="@"){
        var r;
        if(isDouble(b)){
          b = double.parse(b);
        }
        else b = int.parse(b);
        if(a == "sin"){
          if(deg == true){
            b = b * pi / 180;
          }
          r = sin(b);
        }
        else if(a == "cos"){
          r = cos(b);
        }
        else if(a == "tan") {
          r = tan(b);
        }
        else if(a == "lg"){
          r = log(b) / log(10);
        }
        else if(a == "ln"){
          r = log(b);
        }
        else if(a == "√"){
          r = sqrt(b);
        }
        rezultat = r;
        postfixExp.removeAt(index);
        postfixExp.removeAt(index);
        postfixExp.removeAt(index);
        postfixExp.insert(index, r.toString());
        index=-1;
      }
    }
    print("---rezultat="); print(rezultat);
    rezultat = num.parse(rezultat.toStringAsFixed(7));
    int intRezultat = rezultat.round();
    if (rezultat == intRezultat){
      return "$intRezultat";
    }
    return "$rezultat";
  }

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "";
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
        infixExpList = ['0'];
      }
      else if(buttonText == "⌫"){
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(equation == "" || equation=="0"){
          equation = "0";
          infixExpList = ["0"];
          return;
        }
        else if(
          lastChr == "." ||
          isNumeric(lastChr) ||
          lastChr==")" ||
          prec(lastChr) > -1 ||
          lastChr == "√" ||
          lastChr == "e" ||
          lastChr == "π" ||
          equation == "("
        ) {
          equation = equation.substring(0, equation.length - 1);
          infixExpList[infixExpList.length - 1] =
              "${infixExpList[infixExpList.length - 1]}"
                  .substring(
                  0, "${infixExpList[infixExpList.length - 1]}".length - 1);
          var lastElementLength = (infixExpList[infixExpList.length - 1])
              .length;
          if (lastElementLength == 0) {
            infixExpList.removeLast();
          }
        }
          else if(lastChr == "(" ){
            if(infixExpList.length >= 3){
              if(infixExpList[infixExpList.length-2]=="@" && infixExpList[infixExpList.length-3] != "√"){
                int len = "${infixExpList[infixExpList.length-1]}".length
                  + "${infixExpList[infixExpList.length-2]}".length
                  + "${infixExpList[infixExpList.length-3]}".length;
                equation = equation.substring(0, equation.length-len+1);
                infixExpList.removeLast();
                infixExpList.removeLast();
                infixExpList.removeLast();
              }
              else {
                equation = equation.substring(0, equation.length-1);
                infixExpList.removeLast();
              }
            }
            else if(infixExpList[infixExpList.length-2]=="@" && infixExpList[infixExpList.length-3] == "√"){
              infixExpList.removeLast();
            }
          }
          else if(lastChr == "√"){
            infixExpList.removeLast();
            infixExpList.removeLast();
          }
          if(equation == ""){
            equation = "0";
          }
        }
      else if(buttonText == "sin"){
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
          !isNumeric(lastChr) &&
              lastChr != "." &&
              lastChr != ")" &&
              lastChr != "π" &&
              lastChr != "e"
        ){
          equation = equation + buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
        else if(equation == "0"){
          equation = buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
      }
      else if(buttonText == "cos"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != ")" &&
            lastChr != "π" &&
            lastChr != "e"
        ){
          equation = equation + buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
        else if(equation == "0"){
          equation = buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
      }
      else if(buttonText == "tan"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != ")" &&
            lastChr != "π" &&
            lastChr != "e"
        ){
          equation = equation + buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
        else if(equation == "0"){
          equation = buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
      }
      else if(buttonText == "("){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != ")" &&
            lastChr != "" &&
            lastChr != "π" &&
            lastChr != "e"
        ){
          equation = equation + buttonText;
          infixExpList.add("(");
        }
      }
      else if(buttonText == ")"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
            lastChr != "(" &&
            lastChr != "√" &&
            lastChr != "%" &&
            lastChr != "÷" &&
            lastChr != "x" &&
            lastChr != "-" &&
            lastChr != "+" &&
            lastChr != "." &&
            lastChr != "^"
        ){
          equation = equation + buttonText;
          infixExpList.add(")");
        }
      }
      else if(buttonText == "√"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != ")"
        ){
          equation = equation + buttonText;
          infixExpList.add(buttonText);
          infixExpList.add("@");
        }
        else if (equation=="0"){
          equation = buttonText;
          infixExpList.add(buttonText);
          infixExpList.add("@");
        }
      }
      else if(buttonText == "%"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        lastChr != "(" &&
            lastChr != "√" &&
            lastChr != "%" &&
            lastChr != "÷" &&
            lastChr != "x" &&
            lastChr != "-" &&
            lastChr != "+" &&
            lastChr != "." &&
            lastChr != "^"
        ){
          equation = equation + buttonText;
          infixExpList.add(buttonText);
        }
      }
      else if(buttonText == "÷"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        lastChr != "(" &&
            lastChr != "√" &&
            lastChr != "%" &&
            lastChr != "÷" &&
            lastChr != "x" &&
            lastChr != "-" &&
            lastChr != "+" &&
            lastChr != "." &&
            lastChr != "^"
        ){
          equation = equation + buttonText;
          infixExpList.add(buttonText);
        }
      }
      else if(buttonText == "+"){
        var lastChr = equation.substring(equation.length-1, equation.length);
          if(
            lastChr != "(" &&
            lastChr != "√" &&
            lastChr != "%" &&
            lastChr != "÷" &&
            lastChr != "x" &&
            lastChr != "-" &&
            lastChr != "+" &&
            lastChr != "." &&
            lastChr != "^"
        ){
          equation = equation + buttonText;
          infixExpList.add(buttonText);
        }
      }
      else if(buttonText == "-"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(equation == "0"){
          equation = equation + buttonText;
        }
        else if(
        lastChr != "√" &&
            lastChr != "%" &&
            lastChr != "÷" &&
            lastChr != "x" &&
            lastChr != "-" &&
            lastChr != "+" &&
            lastChr != "^" &&
            lastChr != "."
        ){
          equation = equation + buttonText;
          infixExpList.add(buttonText);
        }
      }
      else if(buttonText == "x"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        lastChr != "(" &&
            lastChr != "√" &&
            lastChr != "%" &&
            lastChr != "÷" &&
            lastChr != "x" &&
            lastChr != "-" &&
            lastChr != "+" &&
            lastChr != "." &&
            lastChr != "^"
        ){
          equation = equation + buttonText;
          infixExpList.add(buttonText);
        }
      }
      else if(buttonText == "lg"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
          !isNumeric(lastChr) &&
              lastChr != "." &&
              lastChr != "π" &&
              lastChr != "e" &&
              lastChr != ")"
        ){
          equation = equation + buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
        else if(equation == "0"){
          equation = buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
      }
      else if(buttonText == "ln"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
          !isNumeric(lastChr) &&
              lastChr != "." &&
              lastChr != "π" &&
              lastChr != "e" &&
              lastChr != ")"
        ){
          equation = equation + buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
        else if(equation == "0"){
          equation = buttonText + "(";
          infixExpList.add(buttonText);
          infixExpList.add("@");
          infixExpList.add("(");
        }
      }
      else if(buttonText == "x^"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
            lastChr != "." &&
            lastChr != ")" &&
            equation != "0" &&
            double.parse(infixExpList[infixExpList.length-1]) != 0.0
        ){
          equation = equation + "^";
          infixExpList.add("^");
        }
      }
      else if(buttonText == "π") {
        var lastChr = equation.substring(equation.length - 1, equation.length);
        if (
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != "π" &&
            lastChr != "e" &&
            lastChr != ")"
        ) {
          equation = equation + buttonText;
          infixExpList.add("$pi");
        }
        else if (equation == "0") {
          equation = "$pi";
          infixExpList.add("$pi");
        }
      }
      else if(buttonText == "e"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != "π" &&
            lastChr != "e" &&
            lastChr != ")"
        ){
          equation = equation + buttonText;
          infixExpList.add("$e");
        }
        else if(equation == "0"){
          equation = "$e";
          infixExpList.add("$e");
        }
      }
      else if(buttonText == "0"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
          equation != "0" &&
          lastChr != ")" &&
              lastChr != "π" &&
              lastChr != "e"
        ){
          if("${infixExpList[infixExpList.length-1]}" == "0"){
            return;
          }
          else if(isNumeric(lastChr) || lastChr == "."){
            equation = equation + buttonText;
            infixExpList[infixExpList.length-1] = "${infixExpList[infixExpList.length-1]}" + buttonText;
          } else {
            equation = equation + buttonText;
            infixExpList.add(buttonText);
          }
        }
      }
      else if(isNumeric(buttonText)){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
            lastChr != ")" &&
            lastChr != "π" &&
            lastChr != "e"
        ){
          if(equation == "0"){
            equation = buttonText;
            infixExpList.add(buttonText);
          } else if(isNumeric(lastChr) || lastChr == "."){
            equation = equation + buttonText;
            infixExpList[infixExpList.length-1] = "${infixExpList[infixExpList.length-1]}" + buttonText;
          }
          else {
            equation = equation + buttonText;
            infixExpList.add(buttonText);
          }
        }
      }
      else if(buttonText == "."){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
            isNumeric(lastChr)
        ){
          bool gasitPunct = false;
          String strNumber = "${infixExpList[infixExpList.length-1]}";
          for(int i=0; i<strNumber.length && gasitPunct==false; i++){
            if(strNumber[i]=="."){
              gasitPunct=true;
            }
          }
          if(gasitPunct==false) {
            equation = equation + buttonText;
            infixExpList[infixExpList.length - 1] =
                "${infixExpList[infixExpList.length - 1]}" + buttonText;
          }
        }
      }
      else if(buttonText == "RD"){
        rad = false;
        deg = true;
      }
      else if(buttonText == "DG"){
        rad = true;
        deg = false;
      }
      else if(buttonText == "="){
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
        var postfix = List<String>.from(getPostfix(infixExpList));
        var rezultat = evaluatePostfix(postfix);
        print("rezultat=" + rezultat);
        result = rezultat;
      }
      else {
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
    print(infixExpList);
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1, style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scientific Calculator')),
      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            //child: Text(equation, style: TextStyle(fontSize: equationFontSize), ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(equation, style: TextStyle(fontSize: equationFontSize), ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            //child: Text(result, style: TextStyle(fontSize: resultFontSize), ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(result, style: TextStyle(fontSize: resultFontSize), ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("sin", 1, Colors.blue),
                          buildButton("cos", 1, Colors.blue),
                          buildButton("tan", 1, Colors.blue),
                          buildButton("(", 1, Colors.blue),
                          buildButton(")", 1, Colors.blue)
                        ]
                    ),
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("√", 1, Colors.blue),
                        buildButton("%", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                        buildButton("⌫", 1, Colors.orange)
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("lg", 1, Colors.blue),
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                          buildButton("x", 1, Colors.blue)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("ln", 1, Colors.blue),
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                          buildButton("-", 1, Colors.blue)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("x^", 1, Colors.blue),
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                          buildButton("+", 1, Colors.blue)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("π", 1, Colors.blue),
                          buildButton(rad==true ? "RD" : "DG", 1, Colors.deepPurpleAccent),
                          buildButton("0", 1, Colors.black54),
                          buildButton(".", 1, Colors.black54),
                          buildButton("=", 1, Colors.green)
                        ]
                    )
                  ],
                )
              )
            ],
          ),
        ],
      )
    );
  }
}
