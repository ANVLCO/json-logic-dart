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
  };

  /// A JsonLogic requirement to consistently evaluate arrays
  /// http://jsonlogic.com/truthy
  static bool _truthy(dynamic value) {
    if(value is List) {
      return value.isNotEmpty;
    } else if (value is bool) {
      return !!value;
    } else {
      return value != null;
    }
  }

  static int _safeInt(value) {
   if(value is String) {
     return int.parse(value);
   } else if(value is List) {
     return _safeInt(value.elementAt(0));
   }

   return value;
  }

  static bool _isSingle(list) => (list as List).length == 1;

  static bool _isLogic(logic) {
    return logic is Map;
  }

  static String _getOperator(Map logic) {
    return logic.keys.first;
  }

  static dynamic apply(logic, Map<Symbol, dynamic> data) {
    // You've recursed to a primitive, stop!
    if(! _isLogic(logic)) {
      return logic;
    }

    var op = _getOperator(logic);
    var values = logic[op];

    // easy syntax for unary operators, like {"var" : "x"} instead of strict {"var" : ["x"]}
    if(! (values is List)) {
      values = [values];
    }

    //TODO Implement if, and, or, filter, map, reduce, all, none, some

    // Everyone else gets immediate depth-first recursion
    values = values.map((val) {
      return apply(val, data);
    }).toList();

    if(['cat', '+', '*', '-', 'min', 'max'].contains(op)) {
      return operations[op](values);
    } else {
      return Function.apply(operations[op], values, data);
    }
  }
}
