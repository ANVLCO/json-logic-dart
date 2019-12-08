class JsonLogic {
  static final Map<String, Function> operations = {
    "==" : (a, b)    { return a.equals(b); },
    "===": (a, b)    { return a == b; },
    "!=" : (a, b)    { return ! a.equals(b); },
    "!==": (a, b)    { return a != b; },
    ">"  : (a, b)    { return a > b; },
    ">=" : (a, b)    { return a >= b; },
    "<"  : (a, b, c) { return c == null ? a < b : (a < b) && (b < c); },
    "<=" : (a, b, c) { return c == null ? a <= b : (a <= b) && (b <= c); },
    "!!" : (a)       { return _truthy(a); },
    "!"  : (a)       { return ! _truthy(a); },
    "%"  : (a, b)    { return a % b; },
    "log": (a)       { print(a); return a; },
    "in" : (a, b)    { return (b as List).indexOf(a) >= 0; }
  };

  /// A JsonLogic requirement to consistently evaluate arrays
  /// http://jsonlogic.com/truthy
  static _truthy(dynamic value) {
    return value.isEmpty ?  false : !! value;
  }
}
