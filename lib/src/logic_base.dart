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
    'cat'   :(a)       => (a as List).reduce((val, acc) => val.toString() + acc.toString()),
    'substr':(a, b, c) => (a.toString().substring(b, c)),
    '+'     :(a)       => (a as List).reduce((val, acc) => _safeInt(val) + _safeInt(acc)),
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

  static int _safeInt(value) => value is String ? int.parse(value) : value;

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

    if(['cat', '+'].contains(op)) {
      return operations[op](values);
    } else {
      return Function.apply(operations[op], values, data);
    }
  }
}
