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

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
      }
      else if(buttonText == "⌫"){
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;
        equation = equation.substring(0, equation.length-1);
        if(equation == ""){
          equation = "0";
        }
      }
      else if(buttonText == "sin"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
          !isNumeric(lastChr) &&
              lastChr != "." &&
              lastChr != ")" &&
              lastChr != "π" &&
              lastChr != "e"
        ){
          equation = equation + buttonText;
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
          equation = equation + buttonText;
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
          equation = equation + buttonText;
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
          equation = equation + buttonText;
        }
      }
      else if(buttonText == "ln2"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
          !isNumeric(lastChr) &&
              lastChr != "." &&
              lastChr != "π" &&
              lastChr != "e" &&
              lastChr != ")"
        ){
          equation = equation + buttonText;
        }
      }
      else if(buttonText == "x^"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != "π" &&
            lastChr != "e" &&
            lastChr != ")"
        ){
          equation = equation + buttonText;
        }
      }
      else if(buttonText == "π"){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
        !isNumeric(lastChr) &&
            lastChr != "." &&
            lastChr != "π" &&
            lastChr != "e" &&
            lastChr != ")"
        ){
          equation = equation + buttonText;
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
          equation = equation + buttonText;
        }
      }
      else if(isNumeric(buttonText)){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
            lastChr != ")" &&
            lastChr != "π" &&
            lastChr != "e"
        ){
          equation = equation + buttonText;
        }
      }
      else if(buttonText == "."){
        var lastChr = equation.substring(equation.length-1, equation.length);
        if(
            isNumeric(lastChr)
        ){
          equation = equation + buttonText;
        }
      }
      else if(buttonText == "="){
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
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
            child: Text(equation, style: TextStyle(fontSize: equationFontSize), ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize), ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("sin", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("C", 1, Colors.redAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("lg", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("ln2", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("x^", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("π", 1, Colors.blue),
                        ]
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("cos", 1, Colors.blue),
                          buildButton("tan", 1, Colors.blue),
                          buildButton("(", 1, Colors.blue)
                        ]
                    ),
                    TableRow(
                      children: [
                        buildButton("√", 1, Colors.blue),
                        buildButton("%", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue)
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("e", 1, Colors.blue),
                          buildButton("0", 1, Colors.black54),
                          buildButton(".", 1, Colors.black54)
                        ]
                    )
                  ],
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton(")", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("⌫", 1, Colors.orange),
                        ]
                    ),
                    TableRow(
                      children: [
                        buildButton("x", 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 1, Colors.green),
                        ]
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )

    );
  }
}
