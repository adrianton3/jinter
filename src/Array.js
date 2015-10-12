// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var ARRAY, ARRAY_PROTOTYPE, NATIVE_FUNCTION, NULL, NUMBER, OBJECT, STRING, addMethod, isIntegery, methods;

  OBJECT = jinter.OBJECT, NULL = jinter.NULL, NATIVE_FUNCTION = jinter.NATIVE_FUNCTION, STRING = jinter.STRING, NUMBER = jinter.NUMBER;

  ARRAY = function(data) {
    this.data = data != null ? data : [];
    OBJECT.call(this, ARRAY_PROTOTYPE);
    this.put('prototype', ARRAY_PROTOTYPE);
  };

  ARRAY.prototype = Object.create(OBJECT.prototype);

  ARRAY.prototype.constructor = ARRAY;

  isIntegery = function(value) {
    if (isNaN(value)) {
      return;
    }
    return (parseFloat(value)) === (parseInt(value, 10));
  };

  ARRAY.prototype.get = function(key) {
    if (isIntegery(key)) {
      return this.data[key];
    } else {
      return OBJECT.prototype.get.call(this, key);
    }
  };

  ARRAY.prototype.put = function(key, value) {
    if (isIntegery(key)) {
      return this.data[key] = value;
    } else {
      return OBJECT.prototype.get.call(this, key);
    }
  };

  ARRAY.prototype.toString = function() {
    return this.data.toString();
  };

  ARRAY_PROTOTYPE = new OBJECT(NULL);

  addMethod = function(_arg) {
    var name, returnType;
    name = _arg.name, returnType = _arg.returnType;
    return ARRAY_PROTOTYPE.put(name, new NATIVE_FUNCTION(function() {
      var resultRaw;
      resultRaw = Array.prototype[name].apply(this.data, arguments);
      return {
        "return": true,
        value: returnType != null ? new returnType(resultRaw) : resultRaw
      };
    }));
  };

  methods = [
    {
      name: 'toString',
      returnType: STRING
    }, {
      name: 'slice',
      returnType: ARRAY
    }, {
      name: 'push',
      returnType: NUMBER
    }, {
      name: 'pop'
    }
  ];

  methods.forEach(addMethod);

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.ARRAY = ARRAY;

}).call(this);
