you can run the watch to autorun compiler
   coffee -wc -o lib/ src/*.coffee

without documentation yet, look the demo to understand the framework
   fast doc:

      general grafics objects
          method updade (recive the class context)
              it is call for each iteretion of the game loop. must update the object status
          
          method paint (recive the canvas 2d context)
              it is call for each iteration of the game loop after all the objects to be update
              
      Context (you need extends to custon yours objects and plugins)
          constructor
             create a game instance and the empty objects attribute (default list used by get Objects)
             you need call super at the first line to run
      
          method getObjects
              it is called to get all the grafics objects
              
          method required (recive a plugin class)
              it is used to requister a plugin
              
          attribute game
              represent the game istante for this context
              
      Loop 
          constructor (recive a Context instance, the canvas element and the game fps)
              prepare the game loop to start
              
          method start
              start the game loop
              
          method stop
              spot the game loop
              