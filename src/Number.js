// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var NUMBER, STRING;

  STRING = jinter.STRING;

  NUMBER = function(value) {
    this.value = Number(value);
  };

  NUMBER.prototype.type = 'number';

  NUMBER.prototype.toNumber = function() {
    return this.value;
  };

  NUMBER.prototype.toBoolean = function() {
    return Boolean(this.value);
  };

  NUMBER.prototype.toString = function() {
    return String(this.value);
  };

  NUMBER.prototype.toPrimitive = function() {
    return this;
  };

  NUMBER.prototype.isCallable = function() {
    return false;
  };

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.NUMBER = NUMBER;

}).call(this);
