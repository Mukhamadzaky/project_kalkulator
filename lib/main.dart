// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Sederhana',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Sederhana')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                calc.display,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Baris 1
            _calcRow([
              _buildButton('C', () => calc.clear(), color: Colors.red),
              _buildButton(
                '÷',
                () => calc.setOperation('÷'),
                color: Colors.orange,
              ),
              _buildButton(
                '×',
                () => calc.setOperation('×'),
                color: Colors.orange,
              ),
              _buildButton('⌫', () => calc.backspace(), color: Colors.grey),
            ]),
            // Baris 2
            _calcRow([
              _buildButton('7', () => calc.inputDigit('7')),
              _buildButton('8', () => calc.inputDigit('8')),
              _buildButton('9', () => calc.inputDigit('9')),
              _buildButton(
                '-',
                () => calc.setOperation('-'),
                color: Colors.orange,
              ),
            ]),
            // Baris 3
            _calcRow([
              _buildButton('4', () => calc.inputDigit('4')),
              _buildButton('5', () => calc.inputDigit('5')),
              _buildButton('6', () => calc.inputDigit('6')),
              _buildButton(
                '+',
                () => calc.setOperation('+'),
                color: Colors.orange,
              ),
            ]),
            // Baris 4
            _calcRow([
              _buildButton('1', () => calc.inputDigit('1')),
              _buildButton('2', () => calc.inputDigit('2')),
              _buildButton('3', () => calc.inputDigit('3')),
              _buildButton('=', () => calc.calculate(), color: Colors.green),
            ]),
            // Baris 5: '0' lebar 2 kolom
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  SizedBox(
                    width:
                        MediaQuery.of(context).size.width * 0.5 - 18, // 2 kolom
                    child: _buildButton('0', () => calc.inputDigit('0')),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25 - 18,
                    child: _buildButton('.', () => calc.inputDecimal()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calcRow(List<Widget> buttons) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          buttons.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: buttons[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback? onPressed, {Color? color}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey[300],
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
