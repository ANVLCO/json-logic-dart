import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Value Equality', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ "==" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Unequal integers', () {
      var serialized = '{ "==" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Instance Equality', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ "===" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Unequal integers', () {
      var serialized = '{ "===" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Value Inequality', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ "!=" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Unequal integers', () {
      var serialized = '{ "!=" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Instance Inequality', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ "!==" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Unequal integers', () {
      var serialized = '{ "!==" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Greater Than', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ ">" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Less than integers', () {
      var serialized = '{ ">" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Greater than integers', () {
      var serialized = '{ ">" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Greater Than or Equal To', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ ">=" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Less than integers', () {
      var serialized = '{ ">=" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Greater than integers', () {
      var serialized = '{ ">=" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Less Than', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ "<" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Less than integers', () {
      var serialized = '{ "<" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Greater than integers', () {
      var serialized = '{ "<" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Less Than Equal To', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Equal integers', () {
      var serialized = '{ "<=" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Less than integers', () {
      var serialized = '{ "<=" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Greater than integers', () {
      var serialized = '{ "<=" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Double Negation', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Empty array', () {
      var serialized = '{ "!!" : [[]] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Non-zero array', () {
      var serialized = '{ "!!" : [[\"0\"]] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Boolean true', () {
      var serialized = '{ "!!" : [true] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });

    test('Boolean false', () {
      var serialized = '{ "!!" : [false] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Integer value', () {
      var serialized = '{ "!!" : [1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Logical Negation', () {
    JsonLogic jsonLogic;

    setUp(() {
      jsonLogic = JsonLogic();
    });

    test('Boolean true array', () {
      var serialized = '{ "!" : [[true]] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Boolean true', () {
      var serialized = '{ "!" : [true] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isFalse);
    });

    test('Boolean false', () {
      var serialized = '{ "!" : [false] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(jsonLogic.apply(logic, {}), isTrue);
    });
  });
}
