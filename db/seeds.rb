make = Make.create(name:"BMW")

model2 = Model.create(name: "e90 M3 Sedan", make: make)
model1 = Model.create(name: "e92 M3 Coupe", make: make)
model3 = Model.create(name: "e93 M3 Convertable", make: make)

color = Color.create(name:"Le Mans Blue")
Color.create(name:"Jerez Black")
Color.create(name:"Melbourne Red")
Color.create(name:"Mineral White")
Color.create(name:"Space Gray")
Color.create(name:"Silverstone")
Color.create(name:"Interlagos Blue")
Color.create(name:"Jet Black")
Color.create(name:"Alpine White")
Color.create(name:"Laguna Seca Blue")
Color.create(name:"Brilliant White")
Color.create(name:"Dakar Yellow II")
Color.create(name:"Azurite Black")
Color.create(name:"Moonstone")
Color.create(name:"Atlantis")
Color.create(name:"Black Sapphire")
Color.create(name:"Ruby Black")
Color.create(name:"Frozen Grey")
Color.create(name:"Monte Carlo Blue")
Color.create(name:"Frozen Black")
Color.create(name:"Phoenix Yellow")
Color.create(name:"Titanium Silver")
Color.create(name:"Hellrot")
Color.create(name:"Power Green")
Color.create(name:"Mineral White")
Color.create(name:"Marrakesh Brown")
Color.create(name:"Barbera Red")
Color.create(name:"Midnight Blue")
Color.create(name:"Santorini Blue")

mike = User.create(username:"mikesilvis", password: "michael", email:"mikesilvis@gmail.com")
Garage.create(model: model1, color: color, year: 2011, user: mike)