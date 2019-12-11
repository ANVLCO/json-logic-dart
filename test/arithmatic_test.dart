import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Modulus', () {
    test('Modulus with remainder', () {
      var serialized = '{ "%" : [3, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 1);
    });

    test('Zeros', () {
      var serialized = '{ "%" : [0, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 0);
    });
  });

  group('Addition', () {
    test('integer values', () {
      var serialized = '{ "+" : [3, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 5);
    });

    test('list of integer values', () {
      var serialized = '{ "+" : [3, 2, 1, 99] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 105);
    });

    test('string values', () {
      var serialized = '{ "+" : ["0", "1"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 1);
    });
  });
}