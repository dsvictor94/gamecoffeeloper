class BoundingBox
  constructor: () ->
    @objects = new Array()
    
  add: (id, o) ->
    console.log id, o
    if !@objects[id]?
      @objects[id] = new Array()
    @objects[id].push o
    
  collides: (self, id, index=0) ->
    if !@objects[id]? or !@objects[id][index]?
      false
    else
      r1 = BoundingBox.getRet(self)
      r2 = BoundingBox.getRet(@objects[id][index])
      r2.x2 > r1.x1 and r2.x1 < r1.x2 and r2.y2 > r1.y1 and r2.y1 < r1.y2
      
      
  @getRet: (o) ->
    x = if o.bb_x? then o.bb_x else o.x 
    y = if o.bb_y? then o.bb_y else o.y
    w = if o.bb_width? then o.bb_x else o.width
    h = if o.bb_height? then o.bb_height else o.height
    {x1: x, y1:y, x2: x+w, y2: y+h}
    
@Collision = {BoundingBox: BoundingBox}