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

	"ShowSelectedAction":()->
		Session.get 'curSelectedAnimal'


Template.zoo.events

	"click #start":()->
		runEverySec = ()->
			c = document.getElementById("zoocanvas");
			ctx = c.getContext("2d");			for own k,v of window.allAnimals
				if k is Session.get 'curSelectedAnimal'
					selected = true
				else
					selected = false
				v.DrawSelf(ctx, selected)

		if Session.equals 'running', true
			Meteor.clearInterval(interval)
			Session.set 'running', false
		else
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

		c = document.getElementById("zoocanvas");
		ctx = c.getContext("2d");
		Animals.insert newAnimal
	
	"click #zoocanvas":(e)->
		x = Math.floor((e.pageX-$("#zoocanvas").offset().left));
		y = Math.floor((e.pageY-$("#zoocanvas").offset().top));
		for own k,v of window.allAnimals
			if v.Select(x,y)
				Session.set "curSelectedAnimal", k
				break
	"click #feedBtn":(e)->
		selected = Session.get 'curSelectedAnimal'
		if selected
			window.allAnimals[selected].Feed()
	"click #killBtn":(e)->
		selected = Session.get 'curSelectedAnimal'
		if selected
			window.allAnimals[selected].Die()
