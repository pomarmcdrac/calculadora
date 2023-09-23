import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const CalculadoraCientificaApp());

class CalculadoraCientificaApp extends StatelessWidget {
  const CalculadoraCientificaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculadoraCientifica(),
    );
  }
}

class CalculadoraCientifica extends StatefulWidget {
  const CalculadoraCientifica({super.key});

  @override
  CalculadoraCientificaState createState() => CalculadoraCientificaState();
}

class CalculadoraCientificaState extends State<CalculadoraCientifica> {
  String _expression = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _clear();
      } else {
        _expression += buttonText;
      }
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
    });
  }

  void _calculateResult() {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _expression = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Científica'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('C'),
              _buildButton('+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('('),
              _buildButton(')'),
              _buildButton('^'),
              _buildButton('='),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
