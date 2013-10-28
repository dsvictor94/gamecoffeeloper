// Generated by CoffeeScript 1.4.0
(function() {
  var BoundingBox;

  BoundingBox = (function() {

    function BoundingBox() {
      this.objects = new Array();
    }

    BoundingBox.prototype.add = function(id, o) {
      console.log(id, o);
      if (!(this.objects[id] != null)) {
        this.objects[id] = new Array();
      }
      return this.objects[id].push(o);
    };

    BoundingBox.prototype.collides = function(self, id, index) {
      var r1, r2;
      if (index == null) {
        index = 0;
      }
      if (!(this.objects[id] != null) || !(this.objects[id][index] != null)) {
        return false;
      } else {
        r1 = BoundingBox.getRet(self);
        r2 = BoundingBox.getRet(this.objects[id][index]);
        return r2.x2 > r1.x1 && r2.x1 < r1.x2 && r2.y2 > r1.y1 && r2.y1 < r1.y2;
      }
    };

    BoundingBox.getRet = function(o) {
      var h, w, x, y;
      x = o.bb_x != null ? o.bb_x : o.x;
      y = o.bb_y != null ? o.bb_y : o.y;
      w = o.bb_width != null ? o.bb_x : o.width;
      h = o.bb_height != null ? o.bb_height : o.height;
      return {
        x1: x,
        y1: y,
        x2: x + w,
        y2: y + h
      };
    };

    return BoundingBox;

  })();

  this.Collision = {
    BoundingBox: BoundingBox
  };

}).call(this);
