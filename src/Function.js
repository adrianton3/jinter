// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var EMPTY, FUNCTION, FUNCTION_PROTOTYPE, NULL, OBJECT;

  OBJECT = jinter.OBJECT, NULL = jinter.NULL, EMPTY = jinter.EMPTY;

  FUNCTION_PROTOTYPE = new OBJECT(NULL);

  (function() {
    var apply;
    apply = new jinter.NATIVE_FUNCTION(function(thisArgument, args) {
      return jinter.callRaw(this, thisArgument, args.data, EMPTY);
    });
    return FUNCTION_PROTOTYPE.put('apply', apply);
  })();

  FUNCTION = function(body, env, formalArguments, ownName) {
    this.body = body;
    this.env = env;
    this.formalArguments = formalArguments;
    this.ownName = ownName;
    OBJECT.call(this, FUNCTION_PROTOTYPE);
    this.put('prototype', FUNCTION_PROTOTYPE);
  };

  FUNCTION.prototype = Object.create(OBJECT.prototype);

  FUNCTION.prototype.constructor = FUNCTION;

  FUNCTION.prototype.isCallable = function() {
    return true;
  };

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.FUNCTION = FUNCTION;

}).call(this);
