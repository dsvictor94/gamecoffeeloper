lastTime = 0
vendors = ['webkit','moz']
requestAninFrame = window.requestAnimationFrame
cancelAninFrame = window.cancelAnimationFrame
for vendor in vendors
  if requestAninFrame?
    console.log vendor
    break
  requestAninFrame = window[vendor+"RequestAnimationFrame"]
  cancelAninFrame = window[vendor+"CancelAnimationFrame"]
  
if !requestAninFrame?
  requestAninFrame = (callback, element) ->
    currTime = new Date().getTime()
    timeToCall = Math.max(0, 16 - (currTime-lastTime))
    lastTime = currTime+timeToCall
    id = window.setTimeout((() -> callback(currTime+timeToCall)), timeToCall)
    
  cancelAninFrame = window.clearTimeout

class Game

  constructor: () ->
    @canvas = null
    @lastIteration = null
    @before_objs = new Array()
    @after_objs = new Array()
  
  update_after: ->
    for obj in @after_objs
       obj.update()

  update_before: ->
    for obj in @before_objs
       obj.update()
    
  loop_register: (obj, w="before") ->
      if w == "before"
         @before_objs.push obj
      else if w "after"
         @after_objs.push obj
        
   
wrap = (self, f) ->
  () -> f.call(self)

class Loop
  
  constructor: (@context, @canvas) ->
    @ready = false
    @frame = @canvas.getContext "2d"
    @timer = "undefined"
    @context.size = [@canvas.width, @canvas.height]
    @context.game.canvas = @canvas
    @_loopwrap = wrap(this, @loop)
    @lastTime = 0
    
  start: ->
    @lastTime = new Date()
    @context.load?(wrap(@, @loadOk)) ? @loadOk()
    @context.game.canvas = @canvas
    @_loopwrap()
  
  stop: ->
    @context.destroy?()
    clearInterval(@timer)
    
  loadOk: ->
    @ready = true
  
  loop: (now) ->
    now = now ? new Date()
    dt = (now-@lastTime)/1000
    @context.game.update_before(dt)
    
    if @ready
      obj.update(@context, dt) for obj in @context.getObjects()
      @frame.clearRect(0,0,@canvas.width,@canvas.height)
      for obj in @context.getObjects()
        @frame.save()
        obj.paint(@frame)
        @frame.restore()
    else
      @frame.clearRect(0,0,@canvas.width,@canvas.height)
      @frame.save()
      @context.paintLoad(@frame, dt)
      @frame.restore()
    @context.game.update_after(dt)
    
    @lastTime = now
    @timer = requestAnimationFrame(@_loopwrap)

class Context
  constructor: () ->
    @objects = []
    @game = new Game()
      
  getObjects: ->
    @objects
    
  required: (plugin) ->
    new plugin(@game)
    
  paintLoad: (frame) ->
    frame.fillText("Game CoffeeLoper \n Loading...", @game.canvas.width/2, @game.canvas.height*0.5)
    
@CLOPER = {
  Loop: Loop,
  Game: Game,
  Context: Context,
  VERSION: 0.7
}