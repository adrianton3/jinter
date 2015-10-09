// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var ARRAY, BOOLEAN, FUNCTION, NULL, NUMBER, Nodes, OBJECT, STRING, UNDEFINED, call, computeMemberKey, ev;

  NUMBER = jinter.NUMBER, BOOLEAN = jinter.BOOLEAN, STRING = jinter.STRING, NULL = jinter.NULL, UNDEFINED = jinter.UNDEFINED, FUNCTION = jinter.FUNCTION, OBJECT = jinter.OBJECT, ARRAY = jinter.ARRAY;

  ev = function(exp, env) {
    if (env == null) {
      throw new Error('null env');
    }
    return Nodes[exp.type](exp, env);
  };

  Nodes = {};

  Nodes['Literal'] = function(exp, env) {
    var value;
    value = exp.value;
    switch (exp.dataType) {
      case 'number':
        return new NUMBER(value);
      case 'boolean':
        return new BOOLEAN(value);
      case 'string':
        return new STRING(value);
      case 'object':
        return NULL;
    }
  };

  Nodes['Identifier'] = function(exp, env) {
    return env.get(exp.name);
  };

  (function() {
    var OPERATORS;
    OPERATORS = {
      '+': function(left, right) {
        var leftPrimitive, rightPrimitive;
        leftPrimitive = left.toPrimitive();
        rightPrimitive = right.toPrimitive();
        if (leftPrimitive.type === 'string' || rightPrimitive.type === 'string') {
          return new STRING(leftPrimitive.toString() + rightPrimitive.toString());
        } else {
          return new NUMBER(leftPrimitive.toNumber() + rightPrimitive.toNumber());
        }
      },
      '-': function(left, right) {
        return new NUMBER(left.toNumber() - right.toNumber());
      },
      '*': function(left, right) {
        return new NUMBER(left.toNumber() * right.toNumber());
      }
    };
    return Nodes['BinaryExpression'] = function(exp, env) {
      var left, right;
      left = ev(exp.left, env);
      right = ev(exp.right, env);
      return OPERATORS[exp.operator](left, right);
    };
  })();

  Nodes['ConditionalExpression'] = function(exp, env) {
    var testResult;
    testResult = ev(exp.test, env);
    if (testResult.toBoolean()) {
      return ev(exp.consequent, env);
    } else {
      return ev(exp.alternate, env);
    }
  };

  Nodes['IfStatement'] = function(exp, env) {
    var testResult;
    testResult = ev(exp.test, env);
    if (testResult.toBoolean()) {
      return ev(exp.consequent, env);
    } else {
      return ev(exp.alternate, env);
    }
  };

  Nodes['WhileStatement'] = function(exp, env) {
    var returnCandidate;
    while ((ev(exp.test, env)).toBoolean()) {
      returnCandidate = ev(exp.body, env);
      if (returnCandidate != null ? returnCandidate["return"] : void 0) {
        return returnCandidate;
      }
    }
  };

  Nodes['ForStatement'] = function(exp, env) {
    var returnCandidate;
    ev(exp.init, env);
    while ((ev(exp.test, env)).toBoolean()) {
      returnCandidate = ev(exp.body, env);
      if (returnCandidate != null ? returnCandidate["return"] : void 0) {
        return returnCandidate;
      }
      ev(exp.update, env);
    }
  };

  Nodes['VariableDeclaration'] = function(exp, env) {
    exp.declarations.forEach(function(declaration) {
      var name, value;
      if (declaration.init == null) {
        return;
      }
      name = declaration.id.name;
      value = ev(declaration.init, env);
      env.set(name, value);
    });
  };

  computeMemberKey = function(exp, env) {
    if (exp.computed) {
      return (ev(exp.property, env)).toString();
    } else {
      return exp.property.name;
    }
  };

  Nodes['AssignmentExpression'] = function(exp, env) {
    var key, name, object, value;
    if (exp.left.type === 'MemberExpression') {
      object = ev(exp.left.object, env);
      key = computeMemberKey(exp.left, env);
      value = ev(exp.right, env);
      object.put(key, value);
    } else {
      name = exp.left.name;
      value = ev(exp.right, env);
      env.set(name, value);
    }
    return value;
  };

  Nodes['BlockStatement'] = function(exp, env) {
    var returnCandidate, statement, _i, _len, _ref;
    _ref = exp.body;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      statement = _ref[_i];
      returnCandidate = ev(statement, env);
      if (returnCandidate != null ? returnCandidate["return"] : void 0) {
        return returnCandidate;
      }
    }
  };

  Nodes['ReturnStatement'] = function(exp, env) {
    return {
      "return": true,
      value: ev(exp.argument, env)
    };
  };

  Nodes['ThisExpression'] = function(exp, env) {
    return env.get('this');
  };

  Nodes['ArrayExpression'] = function(exp, env) {
    var array;
    array = new ARRAY;
    exp.elements.forEach(function(element, index) {
      var value;
      value = ev(element, env);
      return array.put(index, value);
    });
    return array;
  };

  Nodes['ObjectExpression'] = function(exp, env) {
    var object;
    object = new OBJECT(NULL);
    exp.properties.forEach(function(property) {
      var name, value;
      name = property.key.name;
      value = ev(property.value, env);
      return object.put(name, value);
    });
    return object;
  };

  Nodes['MemberExpression'] = function(exp, env) {
    var key, object;
    object = ev(exp.object, env);
    key = computeMemberKey(exp, env);
    return object.get(key);
  };

  call = function(exp, env, closure, thisArgument) {
    var args, newEnv;
    if (closure["native"]) {
      args = exp["arguments"].map(function(argument) {
        return ev(argument, env);
      });
      return closure.fun.apply(thisArgument, args);
    }
    newEnv = closure.env.addEntry();
    if (closure.ownName != null) {
      newEnv.addBinding(closure.ownName.name, closure);
    }
    newEnv.addBinding('this', thisArgument);
    exp["arguments"].forEach(function(argument, index) {
      var name, value;
      value = ev(argument, env);
      if (index < closure.formalArguments.length) {
        name = closure.formalArguments[index];
        newEnv.addBinding(name, value);
      }
    });
    closure.body.vars.forEach(function(name) {
      if (!newEnv.entryHas(name)) {
        newEnv.addBinding(name, UNDEFINED);
      }
    });
    closure.body.functionDeclarations.forEach(function(node) {
      var name;
      name = node.id.name;
      closure = ev(node, newEnv);
      newEnv.addBinding(name, closure);
    });
    return ev(closure.body, newEnv);
  };

  Nodes['CallExpression'] = function(exp, env) {
    var closure, key, returnCandidate, thisArgument;
    if (exp.callee.type === 'MemberExpression') {
      thisArgument = ev(exp.callee.object, env);
      key = computeMemberKey(exp.callee, env);
      closure = thisArgument.get(key);
    } else {
      thisArgument = NULL;
      closure = ev(exp.callee, env);
    }
    returnCandidate = call(exp, env, closure, thisArgument);
    if (returnCandidate != null ? returnCandidate["return"] : void 0) {
      return returnCandidate.value;
    } else {
      return UNDEFINED;
    }
  };

  Nodes['NewExpression'] = function(exp, env) {
    var closure, returnCandidate, thisArgument;
    closure = ev(exp.callee, env);
    thisArgument = new OBJECT(closure.get('prototype'));
    returnCandidate = call(exp, env, closure, thisArgument);
    if ((returnCandidate != null ? returnCandidate["return"] : void 0) && returnCandidate.value instanceof OBJECT) {
      return returnCandidate.value;
    } else {
      return thisArgument;
    }
  };

  Nodes['FunctionDeclaration'] = function(exp, env) {
    var formalArguments;
    formalArguments = exp.params.map(function(formalArgument) {
      return formalArgument.name;
    });
    return new FUNCTION(exp.body, env, formalArguments);
  };

  Nodes['FunctionExpression'] = function(exp, env) {
    var formalArguments;
    formalArguments = exp.params.map(function(formalArgument) {
      return formalArgument.name;
    });
    return new FUNCTION(exp.body, env, formalArguments, exp.id);
  };

  Nodes['Program'] = function(exp, env) {
    var newEnv;
    newEnv = env.addEntry();
    exp.vars.forEach(function(name) {
      newEnv.addBinding(name, UNDEFINED);
    });
    exp.functionDeclarations.forEach(function(node) {
      var closure, name;
      name = node.id.name;
      closure = ev(node, newEnv);
      newEnv.addBinding(name, closure);
    });
    return exp.body.reduce(function(prev, statement) {
      return ev(statement, newEnv);
    }, null);
  };

  Nodes['ExpressionStatement'] = function(exp, env) {
    return ev(exp.expression, env);
  };

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.ev = ev;

}).call(this);
