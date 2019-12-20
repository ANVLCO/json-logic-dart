/// Port of json-logic-js
/// Largely a line-by-line rephrasing of the JavaScript library as a Dart library
/// Intentionally trying to keep all side-effects and nuances intact with this version

class JsonLogic {
  static final Map<String, Function> operations = {
    '=='    :(a, b)    => a == b, // Assume everything is a primitive
    '==='   :(a, b)    => a == b,
    '!='    :(a, b)    => a != b, // Assume everything is a primitive
    '!=='   :(a, b)    => a != b,
    '>'     :(a, b)    => a > b,
    '>='    :(a, b)    => a >= b,
    '<'     :(a, b)    => a < b,
    '<='    :(a, b)    => a <= b,
    '!!'    :(a)       => _truthy(a),
    '!'     :(a)       => ! _truthy(a),
    '%'     :(a, b)    => a % b,
    'log'   :(a)       { print(a); return a; },
    'in'    :(a, b)    => b.contains(a),
    'cat'   :(a)       => (a as List).reduce((acc, val) => acc.toString() + val.toString()),
    'substr':(a, b, c) => (a.toString().substring(b, c)),
    '+'     :(a)       => (a as List).reduce((acc, val) => _safeInt(acc) + _safeInt(val)),
    '*'     :(a)       => (a as List).reduce((acc, val) => _safeInt(acc) * _safeInt(val)),
    '-'     :(a)       => _isSingle(a) ? _safeInt(a) * -1 : (a as List).reduce((acc, val) => _safeInt(acc) - _safeInt(val)),
    '/'     :(a, b)    => _safeInt(a) / _safeInt(b),
    'min'   :(a)       => (a as List).reduce((acc, val) => val.toString().compareTo(acc.toString()) < 0 ? val : acc),
    'max'   :(a)       => (a as List).reduce((acc, val) => val.toString().compareTo(acc.toString()) > 0 ? val : acc),
    'merge' :(a)       => (a as List).fold([], (acc, val) { val is Iterable ? acc.addAll(val) : acc.add(val); return acc; }),
  };

  /// A JsonLogic requirement to consistently evaluate arrays
  /// http://jsonlogic.com/truthy
  static bool _truthy(dynamic value) {
    if(value is Iterable) {
      return value.isNotEmpty;
    } else if (value is bool) {
      return value;
    } else if (value is int) {
      return value != 0;
    } else {
      return value != null;
    }
  }

  static int _safeInt(value) {
   if(value is String) {
     return int.parse(value);
   } else if(value is Iterable) {
     return _safeInt(value.single);
   }

   return value;
  }

  static dynamic _dereferenceVariable(String name, defaultValue, data) {
    if(name == null || name == '') {
      return data;
    }

    for(var prop in name.split('.')) {
      if(data == null || data.isEmpty) {
        return defaultValue;
      }

      if(data is Map && data.containsKey(prop)) {
        data = data[prop];
      } else if(data is Iterable) {
        return data.elementAt(int.parse(prop));
      } else {
        return defaultValue;
      }
    }

    return data;
  }

  static bool _isSingle(list) => (list as List).length == 1;

  static bool _isLogic(logic) {
    return logic is Map;
  }

  static String _getOperator(Map logic) {
    return logic.keys.first;
  }

  static dynamic apply(logic, data) {
    // Does this array contain logic? Only one way to find out.
    if(logic is Iterable) {
      return logic.map((l) => apply(l, data));
    }

    // You've recursed to a primitive, stop!
    if(! _isLogic(logic)) {
      return logic;
    }

    data ??= {};

    // easy syntax for unary operators, like {"var" : "x"} instead of strict {"var" : ["x"]}
    var op = _getOperator(logic);
    List values = logic[op] is List ? logic[op] : [ logic[op] ];

    // 'if', 'and', and 'or' violate the normal rule of depth-first calculating consequents, let each manage recursion as needed.
    if(op == 'if' || op == '?:') {
      /* 'if' should be called with a odd number of parameters, 3 or greater
      This works on the pattern:
      if( 0 ){ 1 }else{ 2 };
      if( 0 ){ 1 }else if( 2 ){ 3 }else{ 4 };
      if( 0 ){ 1 }else if( 2 ){ 3 }else if( 4 ){ 5 }else{ 6 };
      The implementation is:
      For pairs of values (0,1 then 2,3 then 4,5 etc)
      If the first evaluates truthy, evaluate and return the second
      If the first evaluates falsy, jump to the next pair (e.g, 0,1 to 2,3)
      given one parameter, evaluate and return it. (it's an Else and all the If/ElseIf were false)
      given 0 parameters, return NULL (not great practice, but there was no Else)
      */
      var i = 0;
      for(; i < values.length - 1; i += 2) {
        if( _truthy( apply(values[i], data) ) ) {
          return apply(values[i + 1], data);
        }
      }

      if(values.length == i + 1) return apply(values[i], data);
      return null;

    } else if(op == 'and') { // Return first falsy, or last
      var current;
      for(var i = 0; i < values.length; ++i) {
        current = apply(values[i], data);
        if( ! _truthy(current)) {
          return current;
        }
      }
      return current; // Last

    } else if(op == 'or') {// Return first truthy, or last
      var current;
      for(var i = 0; i < values.length; ++i) {
        current = apply(values[i], data);
        if( _truthy(current) ) {
          return current;
        }
      }
      return current; // Last

    } else if(op == 'filter'){
      var scopedData = apply(values[0], data);
      var scopedLogic = values[1];

      if (! (scopedData is Iterable)) {
        return [];
      }
      // Return only the elements from the array in the first argument,
      // that return truthy when passed to the logic in the second argument.
      // For parity with JavaScript, reindex the returned array
      return scopedData.where((datum) => _truthy( apply(scopedLogic, datum)));

    } else if(op == 'map'){
      var scopedData = apply(values[0], data);
      var scopedLogic = values[1];

      if (! (scopedData is Iterable)) {
        return [];
      }

      return scopedData.map((datum) => apply(scopedLogic, datum));

    } else if(op == 'reduce'){
      var scopedData = apply(values[0], data);
      var scopedLogic = values[1];
      var initial = values[2];

      if (! (scopedData is Iterable)) {
        return initial;
      }

      return scopedData.fold(
        initial,
        (accumulator, current) =>
          apply(
              scopedLogic,
              {
                'current': current,
                'accumulator':accumulator
              }
          )
      );
    }

    //TODO Implement all, none, some

    // Everyone else gets immediate depth-first recursion
    values = values.map((val) {
      return apply(val, data);
    }).toList();

    // The operation is called with "data" bound to named arguments
    // and "values" passed as positional arguments. Structured commands like %
    // or > can name formal arguments while flexible commands (like missing or
    // merge) can operate on the pseudo-array arguments.
    if(['cat', '+', '*', '-', 'min', 'max', 'merge'].contains(op)) {
      return operations[op](values);
    } else if(op == 'var') {
      var defaultValue = values.length < 2 ? null : values[1];
      var name = values[0] is String ? values[0].trim() : values[0].toString();
      return _dereferenceVariable(name, defaultValue, data);
    } else {
      return Function.apply(operations[op], values);
    }
  }
}
