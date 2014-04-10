root = global ? window

class root.Animal
	constructor:(data)->
		if data?
			@_id = data._id
			@PosX = data.PosX
			@PosY = data.PosY
			@Energy = data.Energy
			@oldPosX = data.oldPosX
			@oldPosY = data.oldPosY
			
		else
			@PosX = Math.floor(Math.random()*500)
			@PosY = Math.floor(Math.random()*500)
			@oldPosX = -1
			@oldPosY = -1
			@Energy = 60
			

	UpdateData:(data)->
		if data?
			@_id = data._id
			@PosX = data.PosX
			@PosY = data.PosY
			@Energy = data.Energy

	Die:()->
		c = document.getElementById("zoocanvas");
		ctx = c.getContext("2d");
		@LastDraw(ctx)
		Animals.remove @_id
	Select:(x,y)->
		if @PosX < x < @PosX + 30 and @PosY < y < @PosY + 30
			true
		else
			false
	Feed:()->
		@Energy = 60
		@UpdateAndSave {Energy:@Energy}
	LastDraw:(ctx)->
		console.log 'last redraw before die'
		if @oldPosX != -1
			#draw old
			ctx.fillStyle = "black" #thisis background color
			ctx.fillRect(@oldPosX, @oldPosY, 30 , 30)
			ctx.fillRect(@PosX, @PosY, 30 , 30)
		if @drawBorder
			ctx.fillStyle = "black"
			ctx.strokeRect(@posX-1, @posY-1, 31, 31)
			@drawBorder = false
	DrawSelf:(ctx, selected)->
		if @oldPosX != -1
			ctx.fillStyle = "black" #thisis background color
			ctx.fillRect(@oldPosX, @oldPosY, 30 , 30)

	
		ctx.fillStyle = @Color()
		ctx.fillRect(@PosX, @PosY, 30 , 30)
		
		
		if selected
			c = Math.floor(@Energy / 60 * 255)
			ctx.fillStyle = "##{c.toString(16)}#{c.toString(16)}#{c.toString(16)}"
			#console.log "draw selected"
			ctx.fillRect(@PosX+10, @PosY+10, 10, 10)


		@oldPosX = @PosX
		@oldPosY = @PosY
	
	Color:->
		console.log "Donot call me, I am a virtual function"

	UpdateAndSave:(obj)->
		Animals.update @_id, $set:obj



class root.Dog extends Animal 
	constructor:(data)->
		if data? and data.AnimalType isnt 'dog'
			console.log  "Not Dog but try to inital as a Dog"
			return


		@AnimalType = "dog"
		super(data)
	Color:()->
		c = Math.floor(@Energy / 60 * 255)
		"##{c.toString(16)}0000"

class root.Cat extends Animal 
	constructor:(data)->
		if data? and data.AnimalType isnt  "cat"
			console.log  "Not Cat but try to inital as a Cat"
			return 
		@AnimalType = "cat"
		super(data)
		
	Color:()->
		c = Math.floor(@Energy / 60 * 255)
		"#00#{c.toString(16)}00"


class root.Bird extends Animal 
	constructor:(data)->
		if data? and data.AnimalType isnt "bird"
			console.log  "Not Bird but try to inital as a Bird"
			return 
		@AnimalType = "bird"
		super(data)
		
	Color:()->
		c = Math.floor(@Energy / 60 * 255)
		"#0000#{c.toString(16)}"

root.InitNewAnimal = (data)->
	switch data.AnimalType
		when "dog"
			return new Dog(data)
		when "cat"
			return new Cat(data)
		when "bird"
			return new Bird(data)
		else
			console.log "No such an animal. No new animal created"


