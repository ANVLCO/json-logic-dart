import 'package:json_logic_dart/logic.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('Fizz Buzz', () {
    test('Fifteen Iterations', () {
      var serialized =
      ''' { 
        "if": [ 
          {"==": [ { "%": [ { "var": "i" }, 15 ] }, 0]}, 
          "fizzbuzz", 
          
          {"==": [ { "%": [ { "var": "i" }, 3 ] }, 0]}, 
          "fizz", 
          
          {"==": [ { "%": [ { "var": "i" }, 5 ] }, 0]}, 
          "buzz", 
          
          { "var": "i" } 
        ]
      }''';

      Map logic = jsonDecode(serialized) as Map<String, dynamic>;

      var response = '';
      for(var i = 1; i <= 15; ++i) {
        response += JsonLogic.apply(logic, { 'i': i }).toString();
      }

      expect(response, '12fizz4buzzfizz78fizzbuzz11fizz1314fizzbuzz');
    });
  });
}
