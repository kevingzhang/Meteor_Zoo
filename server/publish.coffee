Meteor.startup ()->
	console.log "Meteor zoo started"
	runEverySecServer = ()->
		#console.log "run every sec"
		allAnimals = Animals.find().fetch()
		for a in allAnimals
			#console.log "#{JSON.stringify a}"
			if a.Alive
				console.log "a is alive"
				OffsetX = if Math.random() > 0.5 then 10 else -10
				OffsetY = if Math.random() > 0.5 then 10 else -10
				if a.PosX < 30
					OffsetX = 10
				if a.PosX > 500 -30
					OffsetX = -10
				if a.PosY < 30
					OffsetY = 10
				if a.PosY > 500 -30
					OffsetY = -10
				a.oldPosX = a.PosX
				a.oldPosY = a.PosY
				a.PosX += OffsetX
				a.PosY += OffsetY
				#console.log "PosX changed #{OffsetX}"

				if a.Energy > 0 
					a.Energy -= 1
					c = Math.floor(a.Energy / 60 * 255)
					a.Color = "##{c.toString(16)}0000"
					# if a.Energy >= 58
					# 	a.Color = "#FF0000"
					# if 58 > a.Energy >= 40
					# 	a.Color = "#990000"
					# if 40 > a.Energy >= 30
					# 	a.Color = "#770000"
					# if 30 > a.Energy >= 20
					# 	a.Color = "440000"
					# if 20 > a.Energy >= 10
					# 	a.Color = "330000"
					# if 10 > a.Energy >= 0
					# 	a.Color = "000000"
					a.Alive = true
				else
					a.Alive = false

					
				Animals.update a._id, $set:{PosX: a.PosX, PosY:a.PosY, oldPosX:a.oldPosX, oldPosY: a.oldPosY, Energy:a.Energy, Color:a.Color, Alive:a.Alive}
	interval = Meteor.setInterval(runEverySecServer, 1000) 

Meteor.publish "animals", ()->
	Animals.find()