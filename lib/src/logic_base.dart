class JsonLogic {
  static final Map<String, Function> operations = {
    '==' : (a, b)    { return a.equals(b); },
    '===': (a, b)    { return a == b; },
    '!=' : (a, b)    { return ! a.equals(b); },
    '!==': (a, b)    { return a != b; },
    '>'  : (a, b)    { return a > b; },
    '>=' : (a, b)    { return a >= b; },
    '<'  : (a, b, c) { return c == null ? a < b : (a < b) && (b < c); },
    '<=' : (a, b, c) { return c == null ? a <= b : (a <= b) && (b <= c); },
    '!!' : (a)       { return _truthy(a); },
    '!'  : (a)       { return ! _truthy(a); },
    '%'  : (a, b)    { return a % b; },
    'log': (a)       { print(a); return a; },
    'in' : (a, b)    { return (b as List).contains(a); }
  };

  /// A JsonLogic requirement to consistently evaluate arrays
  /// http://jsonlogic.com/truthy
  static _truthy(dynamic value) {
    return value.isEmpty ?  false : !! value;
  }

  bool _isLogic(logic) {
    return logic is Map;
  }

  String _getOperator(Map logic) {
    return logic.keys.first;
  }

  dynamic apply(logic, data) {
    // You've recursed to a primitive, stop!
    if(! _isLogic(logic)) {
      return logic;
    }

    var op = _getOperator(logic);
    var values = logic[op];

    // easy syntax for unary operators, like {"var" : "x"} instead of strict {"var" : ["x"]}
    if( ! values is List) {
      values = [values];
    }

    //TODO Implement if, and, or, filter, map, reduce, all, none, some

    // Everyone else gets immediate depth-first recursion
    values = values.map((val) {
      return apply(val, data);
    });

    print(op);
    print(data);
    print(values);

    return operations[op](data, values);
  }
}
