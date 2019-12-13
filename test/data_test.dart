import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Variables', () {
    test('Return all data with an empty variable', () {
      var serialized = '{ "var" : "" }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, 'Goobers'), 'Goobers');
    });

    test('Return a named variable', () {
      var serialized = '{ "var" : ["a"] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, { 'a': 1, 'b': 2 }), 1);
    });

    test('Named variable syntatic sugar', () {
      var serialized = '{ "var" : "a" }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, { 'a': 1, 'b': 2 }), 1);
    });

    test('Default value', () {
      var serialized = '{ "var" : ["z", 26] }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, { 'a': 1, 'b': 2 }), 26);
    });

    test('Index lookup', () {
      var serialized = '{ "var" : 1 }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, ['zero', 'one', 'two']), 'one');
    });

    test('Dot notation', () {
      var serialized = '{ "var" : "champ.name" }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {'champ': {'name': 'Fezzig'}, 'challenger': {'name': 'Westley'}}), 'Fezzig');
    });
  });
}