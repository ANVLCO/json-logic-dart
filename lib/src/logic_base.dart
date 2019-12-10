class JsonLogic {
  static final Map<String, Function> operations = {
    '==' : (a, b)    { return a == b; }, // Assume everything is a primitive
    '===': (a, b)    { return a == b; },
    '!=' : (a, b)    { return a != b; }, // Assume everything is a primitive
    '!==': (a, b)    { return a != b; },
    '>'  : (a, b)    { return a > b; },
    '>=' : (a, b)    { return a >= b; },
    '<'  : (a, b)    { return a < b; },
    '<=' : (a, b)    { return a <= b; },
    '!!' : (a)       { return _truthy(a); },
    '!'  : (a)       { return ! _truthy(a); },
    '%'  : (a, b)    { return a % b; },
    'log': (a)       { print(a); return a; },
    'in' : (a, b)    { return b.contains(a); }
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

    return Function.apply(operations[op], values, data);
  }
}
