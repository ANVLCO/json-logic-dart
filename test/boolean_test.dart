import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('And Evaluator', () {
    test('Both sides are true', () {
      var serialized = '{"and": [true, true]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), true);
    });

    test('Both sides are false', () {
      var serialized = '{"and": [false, false]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), false);
    });

    test('Left side is true', () {
      var serialized = '{"and": [false, true]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), false);
    });

    test('Right side is true', () {
      var serialized = '{"and": [true, false]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), false);
    });
  });

  group('Or Evaluator', () {
    test('Both sides are true', () {
      var serialized = '{"or": [true, true]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), true);
    });

    test('Both sides are false', () {
      var serialized = '{"or": [false, false]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), false);
    });

    test('Left side is true', () {
      var serialized = '{"or": [false, true]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), true);
    });

    test('Right side is true', () {
      var serialized = '{"or": [true, false]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), true);
    });
  });
}
