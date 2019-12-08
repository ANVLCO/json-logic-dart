import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Equality and Inequality', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Simple equality', () {
      var serialized = '{ "==" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });
  });
}
