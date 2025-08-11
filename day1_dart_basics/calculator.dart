import 'dart:io';

void main() {
  stdout.write("Enter first number: ");
  double? num1 = double.tryParse(stdin.readLineSync() ?? '');

  stdout.write("Enter operator (+, -, *, /): ");
  String op = stdin.readLineSync() ?? '';

  stdout.write("Enter second number: ");
  double? num2 = double.tryParse(stdin.readLineSync() ?? '');

  if (num1 == null || num2 == null) {
      print("Invalid number input");
      return;
    }

    double result;
    switch (op) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          result = num1 / num2;
          break;
        default:
          print("Invalid operator");
          return;
      }

  print("Result: $result");
}
