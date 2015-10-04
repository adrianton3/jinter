// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var OBJECT;

  OBJECT = function(proto) {
    this.proto = proto;
    this.map = new Map;
    this.extensible = true;
  };

  OBJECT.prototype.get = function(key) {
    if (key === '__proto__') {
      return this.proto;
    } else if (this.map.has(key)) {
      return this.map.get(key);
    } else {
      return this.proto.get(key);
    }
  };

  OBJECT.prototype.put = function(key, value) {
    if (key === '__proto__') {
      this.proto = value;
      return;
    }
    if (!this.extensible && !this.map.has(key)) {
      throw new Error("Object is not extensible");
    }
    return this.map.set(key, value);
  };

  OBJECT.prototype.seal = function() {
    return this.extensible = false;
  };

  OBJECT.prototype.toNumber = function() {
    var toString, valueOf;
    valueOf = this.get('valueOf');
    if (valueOf != null ? valueOf.isCallable() : void 0) {
      return valueOf.call(this);
    }
    toString = this.get('toString');
    if (toString != null ? toString.isCallable() : void 0) {
      return toString.call(this);
    }
    throw new Error('Cannot convert object to primitive value');
  };

  OBJECT.prototype.toBoolean = function() {
    return true;
  };

  OBJECT.prototype.toString = function() {
    var toString, valueOf;
    toString = this.get('toString');
    if (toString != null ? toString.isCallable() : void 0) {
      return toString.call(this);
    }
    valueOf = this.get('valueOf');
    if (valueOf != null ? valueOf.isCallable() : void 0) {
      return valueOf.call(this);
    }
    throw new Error('Cannot convert object to primitive value');
  };

  OBJECT.prototype.isCallable = function() {
    return false;
  };

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.OBJECT = OBJECT;

}).call(this);
