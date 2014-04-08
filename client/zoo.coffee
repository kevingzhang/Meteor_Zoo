#template
root = global ? window

Template.zoo.helpers
	"Greeting":()->
		if Session.equals 'running',true
			"Click to stop"
		else
			"Click here to start"
	"ShowButton":()->
		Session.equals 'running', true

Template.zoo.events

	"click #start":()->
		runEverySec = ()->
			#update server's new animal
			#console.log "every sec"
			c = document.getElementById("zoocanvas");
			ctx = c.getContext("2d");
			animals = Animals.find().fetch()
			for q in animals
				unless window.allAnimals[q._id]?
					#new animal added from server
					if q.Alive
						console.log "create new from database"
						window.allAnimals[q._id] = root.InitNewAnimal(q)
				else
					unless q.Alive
						console.log "removed dead"
						window.allAnimals[q._id].LastDraw(ctx)
						delete window.allAnimals[q._id]
					else
						console.log "updated"
						window.allAnimals[q._id].UpdateData(q)
			
			for own k,v of window.allAnimals
				if q.Alive
					console.log "DRaw myself"
					v.DrawSelf(ctx)

		if Session.equals 'running', true
			Meteor.clearInterval(interval)
			Session.set 'running', false
		else
			animals = Animals.find().fetch()
			for q in animals
				console.log "every q"
				unless window.allAnimals[q._id]?
					console.log "before alive #{q.Alive}"
					if q.Alive
						#there is new animal from server
						console.log "add new from database"
						window.allAnimals[q._id] = root.InitNewAnimal(q)
			console.log "client start timer"
			interval = Meteor.setInterval(runEverySec, 1000)
			Session.set 'running', true
	"click .addpet":(e)->
		#alert("new animal will be added")
		petType = e.target.getAttribute "data-pet"
		r = Math.random()
		switch petType
			when "cat"
				newAnimal = new root.Cat()
			when 'dog'
				newAnimal = new root.Dog()
			when "bird"
				newAnimal = new root.Bird()
		console.log "new animal is " + JSON.stringify newAnimal
		if newAnimal instanceof root.Cat
			console.log "instance of Cat"
		if newAnimal instanceof root.Animal
			console.log "instance of Animal"
		if newAnimal instanceof root.Dog
			console.log "instance of Dog"

		newAnimal.name = newAnimal.name
		# if r > 66
		# 	newAnimal = new dog()
		# else if r < 33
		# 	newAnimal = new bird()
		# else
		# 	newAnimal = new cat()

		c = document.getElementById("zoocanvas");
		ctx = c.getContext("2d");
		#newAnimal.DrawSelf ctx
		Animals.insert newAnimal
	
	"click #zoocanvas":(e)->
		x = Math.floor((e.pageX-$("#zoocanvas").offset().left));
		y = Math.floor((e.pageY-$("#zoocanvas").offset().top));
		for own k,v of window.allAnimals
			v.Feed(x,y)
