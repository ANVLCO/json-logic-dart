import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('If/Then Arguments', () {
    test('Condition is True', () {
      var serialized = '{"if" : [ true, "yes", "no" ]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'yes');
    });

    test('Condition is False', () {
      var serialized = '{"if" : [ false, "yes", "no" ]}';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'no');
    });
  });

  group('If/ElseIf/Else Arguments', () {
    test('First Condition is True', () {
      var serialized =
      '''{
        "if" : [ 
          {"<": [-10, 0] }, "freezing", 
          {"<": [-10, 100] }, "liquid", 
          "gas" 
        ]
      }''';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'freezing');
    });

    test('Second Condition is True', () {
      var serialized =
      '''{
        "if" : [ 
          {"<": [55, 0] }, "freezing", 
          {"<": [55, 100] }, "liquid", 
          "gas" 
        ]
      }''';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'liquid');
    });

    test('No Conditions are True', () {
      var serialized =
      '''{
        "if" : [ 
          {"<": [110, 0] }, "freezing", 
          {"<": [110, 100] }, "liquid", 
          "gas" 
        ]
      }''';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'gas');
    });

    test('Multiple Conditions are True', () {
      var serialized =
      '''{
        "if" : [ 
          {"<": [-10, 0] }, "freezing", 
          {"<": [55, 100] }, "liquid", 
          "gas" 
        ]
      }''';
      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      expect(JsonLogic.apply(logic, {}), 'freezing');
    });
  });
}
