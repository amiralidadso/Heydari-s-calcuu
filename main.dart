import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  String selectedOperation = 'Add';
  String result = '';

  final operations = [
    'Add',
    'Subtract',
    'Multiply',
    'Divide',
    'Sin',
    'Cos',
    'Tan',
    'Cot',
  ];

  void calculate() {
    double num1 = double.tryParse(controller1.text) ?? 0;
    double num2 = double.tryParse(controller2.text) ?? 0;
    double res;

    try {
      switch (selectedOperation) {
        case 'Add':
          res = num1 + num2;
          break;
        case 'Subtract':
          res = num1 - num2;
          break;
        case 'Multiply':
          res = num1 * num2;
          break;
        case 'Divide':
          if (num2 == 0) throw Exception('Division by zero');
          res = num1 / num2;
          break;
        case 'Sin':
          res = math.sin(num1 * math.pi / 180);
          break;
        case 'Cos':
          res = math.cos(num1 * math.pi / 180);
          break;
        case 'Tan':
          res = math.tan(num1 * math.pi / 180);
          break;
        case 'Cot':
          double tanVal = math.tan(num1 * math.pi / 180);
          if (tanVal == 0) throw Exception('Cotangent undefined');
          res = 1 / tanVal;
          break;
        default:
          throw Exception('Unknown operation');
      }

      setState(() {
        result = 'Result: ${res.toStringAsFixed(5)}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scientific Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'First Number / Angle'),
            ),
            TextField(
              controller: controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Second Number (if needed)'),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedOperation,
              onChanged: (value) {
                setState(() {
                  selectedOperation = value!;
                });
              },
              items: operations
                  .map((op) => DropdownMenuItem(value: op, child: Text(op)))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
