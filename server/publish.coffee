Meteor.startup ()->
	console.log "Meteor zoo started"
	runEverySecServer = ()->
		#console.log "run every sec"
		allAnimals = Animals.find().fetch()
		for a in allAnimals
			OffsetX = if Math.random() > 0.5 then 10 else -10
			OffsetY = if Math.random() > 0.5 then 10 else -10
			if a.PosX < 30
				OffsetX = 10
			if a.PosX > 500 -40
				OffsetX = -10
			if a.PosY < 30
				OffsetY = 10
			if a.PosY > 500 -40
				OffsetY = -10
			a.oldPosX = a.PosX
			a.oldPosY = a.PosY
			a.PosX += OffsetX
			a.PosY += OffsetY

			if a.Energy > 0 
				a.Energy -= 1
				c = Math.floor(a.Energy / 60 * 255)
				a.Color = "##{c.toString(16)}0000"
				Animals.update a._id, $set:{PosX: a.PosX, PosY:a.PosY, oldPosX:a.oldPosX, oldPosY: a.oldPosY, Energy:a.Energy, Color:a.Color}
			else
				Animals.remove a._id

				
			
	interval = Meteor.setInterval(runEverySecServer, 1000) 

Meteor.publish "animals", ()->
	Animals.find()