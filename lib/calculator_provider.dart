// lib/calculator_provider.dart
import 'package:flutter/foundation.dart';

class CalculatorProvider with ChangeNotifier {
  String _input = '0';
  double _result = 0;
  String _operation = '';
  bool _isNewEntry = true;

  String get display => _input;
  double get result => _result;

  void inputDigit(String digit) {
    // If currently showing error, start fresh
    if (_input == 'Error') {
      _input = digit;
      _isNewEntry = false;
    } else if (_isNewEntry) {
      _input = digit;
      _isNewEntry = false;
    } else {
      if (_input == '0') {
        _input = digit;
      } else {
        _input += digit;
      }
    }
    notifyListeners();
  }

  void inputDecimal() {
    if (_input == 'Error') {
      _input = '0.';
      _isNewEntry = false;
      notifyListeners();
      return;
    }
    if (_isNewEntry) {
      _input = '0.';
      _isNewEntry = false;
    } else if (!_input.contains('.')) {
      _input += '.';
    }
    notifyListeners();
  }

  void clear() {
    _input = '0';
    _result = 0;
    _operation = '';
    _isNewEntry = true;
    notifyListeners();
  }

  void setOperation(String op) {
    if (_input == 'Error') {
      // Reset error so new operation can start with zero
      _input = '0';
      _result = 0;
    }
    if (_operation.isNotEmpty) {
      calculate();
    } else {
      _result = double.tryParse(_input) ?? 0;
    }
    _operation = op;
    _isNewEntry = true;
  }

  void calculate() {
    if (_input == 'Error') return;
    final current = double.tryParse(_input) ?? 0;
    switch (_operation) {
      case '+':
        _result += current;
        break;
      case '-':
        _result -= current;
        break;
      case '×':
        _result *= current;
        break;
      case '÷':
        if (current != 0) {
          _result /= current;
        } else {
          _input = 'Error';
          notifyListeners();
          return;
        }
        break;
      default:
        _result = current;
    }
    _input = _result
        .toStringAsPrecision(_result == _result.truncateToDouble() ? 1 : 10)
        .replaceAll(RegExp(r'\.?0+$'), '');
    _operation = '';
    _isNewEntry = true;
    notifyListeners();
  }

  void backspace() {
    if (_input == 'Error') {
      clear();
      return;
    }
    if (_isNewEntry) return;
    if (_input.length <= 1) {
      _input = '0';
    } else {
      _input = _input.substring(0, _input.length - 1);
    }
    notifyListeners();
  }
}
