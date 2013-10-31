
window.addEventListener "keydown", (e) ->
  Instant.keys[e.keyCode] = true

window.addEventListener "keyup", (e) ->
  Instant.keys[e.keyCode] = false

window.addEventListener "mousemove", (e) ->
  Instant.mousePoint = [e.clientX, e.clientY]

window.addEventListener "mousedown", (e) ->
  Instant.mouseDown[e.button] = true;
  
window.addEventListener "mouseup", (e) ->
  Instant.mouseDown[e.button] = false;

class Instant
  @keys = new Array()
  @mousePoint = new Array(2)
  @mouseDown = new Array(3)
  
class Mouse
   constructor: (@game) ->
      @_lclick = new Array()
      @_click = new Array()
      @game.loop_register(@, "before")
      
   point: ->
      x = Instant.mousePoint[0]-@game.canvas.getBoundingClientRect().left
      y = Instant.mousePoint[1]-@game.canvas.getBoundingClientRect().top
    
      if x < 0 or y < 0
        [null, null]
      else if x > @game.canvas.getBoundingClientRect().width or y > @game.canvas.getBoundingClientRect().height
        [null, null]
      else
        [x, y]

   down: (btn) -> 
      Instant.mouseDown[btn]  
  
   click: (btn) ->
      @_click[btn]
      
   update: ->
      (@_click[btn] = @_lclick[btn] and not val for val, btn in Instant.mouseDown)
      (@_lclick[btn] = val for val, btn in Instant.mouseDown)

class Keyboard
   key: (id) -> 
      switch id
         when "UP" then code = 38 
         when "DOWN" then code = 40
         when "LEFT" then code = 37
         when "RIGHT" then code = 39
         else code = id
      Instant.keys[code] or false
      
@Controller = {Mouse: Mouse, Keyboard: Keyboard}