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
  
  constructor: (@context, @canvas, @fps=60) ->
    @frame = @canvas.getContext "2d"
    @timer = "undefined"
    @context.size = [@canvas.width, @canvas.height]
    @context.game.canvas = @canvas
    
  start: ->
    @context.load?()
    @context.game.canvas = @canvas
    @timer = setInterval(wrap(@, @loop), 1000/@fps)
  
  stop: ->
    @context.destroy?()
    clearInterval @timer
  
  loop: ->
    @context.game.update_before()
    
    obj.update @context for obj in @context.getObjects()
    @frame.clearRect(0,0,@canvas.width,@canvas.height);
    obj.paint @frame for obj in @context.getObjects()
    
    @context.game.update_after()

class Context
  constructor: () ->
    @objects = []
    @game = new Game()
      
  getObjects: ->
    @objects
    
  required: (plugin) ->
    new plugin(@game)

@CLOPER = {
  Loop: Loop,
  Game: Game,
  Context: Context,
  VERSION: 0.7
}