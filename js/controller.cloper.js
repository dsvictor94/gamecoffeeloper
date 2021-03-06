// Generated by CoffeeScript 1.4.0
(function() {
  var Instant, Keyboard, Mouse;

  window.addEventListener("keydown", function(e) {
    return Instant.keys[e.keyCode] = true;
  });

  window.addEventListener("keyup", function(e) {
    return Instant.keys[e.keyCode] = false;
  });

  window.addEventListener("mousemove", function(e) {
    return Instant.mousePoint = [e.clientX, e.clientY];
  });

  window.addEventListener("mousedown", function(e) {
    return Instant.mouseDown[e.button] = true;
  });

  window.addEventListener("mouseup", function(e) {
    return Instant.mouseDown[e.button] = false;
  });

  Instant = (function() {

    function Instant() {}

    Instant.keys = new Array();

    Instant.mousePoint = new Array(2);

    Instant.mouseDown = new Array(3);

    return Instant;

  })();

  Mouse = (function() {

    function Mouse(game) {
      this.game = game;
      this._lclick = new Array();
      this._click = new Array();
      this.game.loop_register(this, "before");
    }

    Mouse.prototype.point = function() {
      var x, y;
      x = Instant.mousePoint[0] - this.game.canvas.getBoundingClientRect().left;
      y = Instant.mousePoint[1] - this.game.canvas.getBoundingClientRect().top;
      if (x < 0 || y < 0) {
        return [null, null];
      } else if (x > this.game.canvas.getBoundingClientRect().width || y > this.game.canvas.getBoundingClientRect().height) {
        return [null, null];
      } else {
        return [x, y];
      }
    };

    Mouse.prototype.down = function(btn) {
      return Instant.mouseDown[btn];
    };

    Mouse.prototype.click = function(btn) {
      return this._click[btn];
    };

    Mouse.prototype.update = function() {
      var btn, val, _i, _j, _len, _len1, _ref, _ref1, _results;
      _ref = Instant.mouseDown;
      for (btn = _i = 0, _len = _ref.length; _i < _len; btn = ++_i) {
        val = _ref[btn];
        this._click[btn] = this._lclick[btn] && !val;
      }
      _ref1 = Instant.mouseDown;
      _results = [];
      for (btn = _j = 0, _len1 = _ref1.length; _j < _len1; btn = ++_j) {
        val = _ref1[btn];
        _results.push(this._lclick[btn] = val);
      }
      return _results;
    };

    return Mouse;

  })();

  Keyboard = (function() {

    function Keyboard() {}

    Keyboard.prototype.key = function(id) {
      var code;
      switch (id) {
        case "UP":
          code = 38;
          break;
        case "DOWN":
          code = 40;
          break;
        case "LEFT":
          code = 37;
          break;
        case "RIGHT":
          code = 39;
          break;
        default:
          code = id;
      }
      return Instant.keys[code] || false;
    };

    return Keyboard;

  })();

  this.Controller = {
    Mouse: Mouse,
    Keyboard: Keyboard
  };

}).call(this);
