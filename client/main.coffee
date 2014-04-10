root = global ? window
Deps.autorun ()->
	Meteor.subscribe "animals"
Deps.autorun ()->
	animals = Animals.find()
	animals.observe
		added: (document)->
			console.log "added new doc"
			window.allAnimals[document._id] = root.InitNewAnimal document
		changed: (newDoc, oldDoc)->
			#console.log "changed doc"
			window.allAnimals[oldDoc._id] = root.InitNewAnimal newDoc
		removed: (oldDoc)->
			console.log "removed doc"
			delete window.allAnimals[oldDoc._id]


window.allAnimals = {}