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

  group('Multiplication', () {
    test('integer values', () {
      var serialized = '{ "*" : [3, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 6);
    });

    test('list of integer values', () {
      var serialized = '{ "*" : [3, 2, 1, 5] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 30);
    });

    test('string values', () {
      var serialized = '{ "*" : ["0", "1"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 0);
    });
  });

  group('Subtraction', () {
    test('integer values', () {
      var serialized = '{ "-" : [3, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 1);
    });

    test('single value', () {
      var serialized = '{ "-" : [3] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), -3);
    });

    test('string values', () {
      var serialized = '{ "-" : ["0", "1"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), -1);
    });
  });

  group('Division', () {
    test('integer values', () {
      var serialized = '{ "/" : [4, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 2);
    });

    test('string values', () {
      var serialized = '{ "/" : ["0", "1"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 0);
    });
  });

  group('Minimum', () {
    test('integer values', () {
      var serialized = '{ "min" : [4, 2, 9] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 2);
    });

    test('string values', () {
      var serialized = '{ "min" : ["cab", "bac", "zaz"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'bac');
    });
  });

  group('Maximum', () {
    test('integer values', () {
      var serialized = '{ "max" : [4, 2, 9] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 9);
    });

    test('string values', () {
      var serialized = '{ "max" : ["cab", "bac", "zaz"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'zaz');
    });
  });

  group('Random', () {
    test('returns item from array', () {
      var serialized = '{ "rand" : ["a", "b", "c", "d", "e"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;
      var result = JsonLogic.apply(logic, {});
      expect(["a", "b", "c", "d", "e"].contains(result), true);
    });

    test('works with single item', () {
      var serialized = '{ "rand" : ["only"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;
      expect(JsonLogic.apply(logic, {}), "only");
    });

    test('works with integers', () {
      var serialized = '{ "rand" : [1, 2, 3, 4, 5] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;
      var result = JsonLogic.apply(logic, {});
      expect([1, 2, 3, 4, 5].contains(result), true);
    });

    test('works with var operator', () {
      var serialized = '{ "rand" : {"var": "pool"} }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;
      var result = JsonLogic.apply(logic, {"pool": ["x", "y", "z"]});
      expect(["x", "y", "z"].contains(result), true);
    });
  });
}