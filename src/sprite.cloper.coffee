class @Sprite
  constructor: (@img,
		@pos=[0,0],
		@size=[16, 16],
		@speed=0,
		@frames=[0],
		@horizontal=true) ->
    @_index=0
  
  update: (dt) ->
    @_index += @speed*dt

  paint: (ctx) ->
    max = @frames.length
    idx = Math.floor(@_index)
    frame = @frames[idx%max]
    @_index -= max*Math.floor(@_index/max)
    
    x = @pos[0]
    y = @pos[1]  
      
    if @horizontal
      x += frame*@size[0]
    else
      y += frame*@size[1]
    
    ctx.drawImage(@img, x, y, @size[0], @size[1],
                       0, 0, @size[0], @size[1])