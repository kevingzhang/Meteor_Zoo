class @animal
	constructor:(data)->
		if data?
			@_id = data._id
			@PosX = data.PosX
			@PosY = data.PosY
			@Color = data.Color
			@Energy = data.Energy
			@Alive = data.Alive
			@oldPosX = data.oldPosX
			@oldPosY = data.oldPosY
			
		else
			@PosX = Math.floor(Math.random()*500)
			@PosY = Math.floor(Math.random()*500)
			@oldPosX = -1
			@oldPosY = -1
			@Color = "#FF0000"
			@Energy = 60
			@Alive = true




	UpdateData:(data)->
		if data?
			@_id = data._id
			@PosX = data.PosX
			@PosY = data.PosY
			@Color = data.Color
			@Energy = data.Energy
			@Alive = data.Alive
			#@oldPosX = data.oldPosX
			#@oldPosY = data.oldPosY

	# EnergyConsumpt:(step)->
	# 	if @Energy > 0 
	# 		@Energy -= step
	# 		if @Energy >= 58
	# 			@Color = "#FF0000"
	# 		if 58 > @Energy >= 40
	# 			@Color = "#990000"
	# 		if 40 > @Energy >= 30
	# 			@Color = "#770000"
	# 		if 30 > @Energy >= 20
	# 			@Color = "440000"
	# 		if 20 > @Energy >= 10
	# 			@Color = "330000"
	# 		if 10 > @Energy >= 0
	# 			@Color = "000000"
	# 		@UpdateAndSave {Energy:@Energy}
	# 		return false
	# 	else
	# 		return true
			

	Die:()->
		#Animals.remove @_id
		@Alive = false
		@UpdateAndSave {Alive:@Alive}

	Feed:(x,y)->
		if @PosX < x < @PosX + 30 and @PosY < y < @PosY + 30
			@Energy = 60
			@UpdateAndSave {Energy:@Energy}
	LastDraw:(ctx)->
		console.log 'last redraw before die'
		if @oldPosX != -1
			#draw old
			ctx.fillStyle = "green" #thisis background color
			ctx.fillRect(@oldPosX, @oldPosY, 30 , 30)
			ctx.fillRect(@PosX, @PosY, 30 , 30)
	DrawSelf:(ctx)->
		console.log "Old: #{@oldPosX}, #{@oldPosY}, new #{@PosX}, #{@PosY}"
		if @oldPosX != -1
			#draw old
			ctx.fillStyle = "green" #thisis background color
			ctx.fillRect(@oldPosX, @oldPosY, 30 , 30)
		#draw new
		if @Alive
			ctx.fillStyle = @Color
			ctx.fillRect(@PosX, @PosY, 30 , 30)
			@oldPosX = @PosX
			@oldPosY = @PosY
		else
			@oldPosX = -1
			@oldPosY = -1

	# DrawNewPos: (ctx)->
	# 	ctx.fillStyle = @Color
	# 	ctx.fillRect(@PosX, @PosY, 30 , 30)
	# RedrawOldPos:(ctx)->
	# 	ctx.fillStyle = "green" #thisis background color
	# 	ctx.fillRect(@PosX, @PosY, 30 , 30)

	UpdateAndSave:(obj)->
		Animals.update @_id, $set:obj
	
	# randomMove:(ctx)->
	# 	OffsetX = if Math.random() > 0.5 then 10 else -10
	# 	OffsetY = if Math.random() > 0.5 then 10 else -10
	# 	if @PosX < 30
	# 		OffsetX = 10
	# 	if @PosX > 500 -30
	# 		OffsetX = -10
	# 	if @PosY < 30
	# 		OffsetY = 10
	# 	if @PosY > 500 -30
	# 		OffsetY = -10

		

	# 	@RedrawOldPos(ctx)
	# 	@PosX += OffsetX
	# 	@PosY += OffsetY
	# 	if @EnergyConsumpt(1)
	# 		@Die()
	# 	else
	# 		@DrawNewPos(ctx)
	# 		@UpdateAndSave {PosX: @PosX, PosY:@PosY}
		





