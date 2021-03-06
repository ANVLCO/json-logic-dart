import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Value Equality', () {
    test('Equal integers', () {
      var serialized = '{ "==" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Unequal integers', () {
      var serialized = '{ "==" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Instance Equality', () {
    test('Equal integers', () {
      var serialized = '{ "===" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Unequal integers', () {
      var serialized = '{ "===" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Value Inequality', () {
    test('Equal integers', () {
      var serialized = '{ "!=" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Unequal integers', () {
      var serialized = '{ "!=" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Instance Inequality', () {
    test('Equal integers', () {
      var serialized = '{ "!==" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Unequal integers', () {
      var serialized = '{ "!==" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Greater Than', () {
    test('Equal integers', () {
      var serialized = '{ ">" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Less than integers', () {
      var serialized = '{ ">" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Greater than integers', () {
      var serialized = '{ ">" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Greater Than or Equal To', () {
    test('Equal integers', () {
      var serialized = '{ ">=" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Less than integers', () {
      var serialized = '{ ">=" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Greater than integers', () {
      var serialized = '{ ">=" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Less Than', () {
    test('Equal integers', () {
      var serialized = '{ "<" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Less than integers', () {
      var serialized = '{ "<" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Greater than integers', () {
      var serialized = '{ "<" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Less Than Equal To', () {
    test('Equal integers', () {
      var serialized = '{ "<=" : [1, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Less than integers', () {
      var serialized = '{ "<=" : [1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Greater than integers', () {
      var serialized = '{ "<=" : [2, 1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Double Negation', () {
    test('Empty array', () {
      var serialized = '{ "!!" : [[]] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Non-zero array', () {
      var serialized = '{ "!!" : [[\"0\"]] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Boolean true', () {
      var serialized = '{ "!!" : [true] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Boolean false', () {
      var serialized = '{ "!!" : [false] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Integer value', () {
      var serialized = '{ "!!" : [1] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });
  });

  group('Logical Negation', () {
    test('Boolean true array', () {
      var serialized = '{ "!" : [[true]] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Boolean true', () {
      var serialized = '{ "!" : [true] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Boolean false', () {
      var serialized = '{ "!" : [false] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });
  });
}
