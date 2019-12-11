import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Log', () {
    test('Value is returned back', () {
      var serialized = '{ "log" : "I dunno man" }';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'I dunno man');
    });
  });
}