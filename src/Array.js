// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var ARRAY, NULL, OBJECT, isIntegery;

  OBJECT = jinter.OBJECT, NULL = jinter.NULL;

  ARRAY = function() {
    OBJECT.call(this, NULL);
    this.data = [];
    this.put('prototype', new OBJECT(NULL));
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

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.ARRAY = ARRAY;

}).call(this);
