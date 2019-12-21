import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Missing', () {
    test('Identify missing data', () {
      var serialized = '{"missing":["a", "b"]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {'a': 'apple', 'c': 'carrot'}), ['b']);
    });

    test('No missing data', () {
      var serialized = '{"missing":["a", "b"]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {'a': 'apple', 'b': 'bananas'}), []);
    });

    test('Empty missing list', () {
      var serialized = '{"missing":[]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {'a': 'apple', 'c': 'carrot'}), []);
    });

    test('Identify missing data from an array', () {
      var serialized = '{"missing":[ ["a", "b"] ]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {'a': 'apple', 'c': 'carrot'}), ['b']);
    });

    group('Missing Some', ()
    {
      test('Not missing data', () {
        var serialized = '{"missing_some":[1, ["a", "b", "c"]]}';
        Map logic = jsonDecode(serialized) as Map<String, dynamic>;

        expect(JsonLogic.apply(logic, {'a': 'apple'}), []);
      });

      test('Missing data', () {
        var serialized = '{"missing_some":[2, ["a", "b", "c"]]}';
        Map logic = jsonDecode(serialized) as Map<String, dynamic>;

        expect(JsonLogic.apply(logic, {'a': 'apple'}), ['b', 'c']);
      });
    });
  });
}