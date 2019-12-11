import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('In', () {
    test('String within a string', () {
      var serialized = '{ "in" : ["Spring", "Springfield"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('String not in a string', () {
      var serialized = '{ "in" : ["Sprong", "Springfield"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });

    test('Item within an array', () {
      var serialized = '{"in" : [ "Ringo", ["John", "Paul", "George", "Ringo"] ]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isTrue);
    });

    test('Item not within an array', () {
      var serialized = '{"in" : [ "Mitch", ["John", "Paul", "George", "Ringo"] ]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), isFalse);
    });
  });

  group('Concatenate', () {
    test('Concatenate strings', () {
      var serialized = '{ "cat" : ["Spring", "Field", "New", "York"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'SpringFieldNewYork');
    });

    test('Concatenate integers', () {
      var serialized = '{ "cat" : [1, 3, 9, 12] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), '13912');
    });
  });

  group('Substring', () {
    test('Empty string', () {
      var serialized = '{ "substr" : ["", 1, 2] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(() => JsonLogic.apply(logic, {}), throwsRangeError);
    });

    test('Start out of bounds', () {
      var serialized = '{ "substr" : ["hi", 2, 3] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(() => JsonLogic.apply(logic, {}), throwsRangeError);
    });

    test('End out of bounds', () {
      var serialized = '{ "substr" : ["hi", 1, 3] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(() => JsonLogic.apply(logic, {}), throwsRangeError);
    });

    test('Trim end of string', () {
      var serialized = '{ "substr" : ["hello", 2, 3] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'l');
    });
  });
}
