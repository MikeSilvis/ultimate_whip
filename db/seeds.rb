make = Make.find_or_create_by_name(name:"BMW")

model2 = Model.find_or_create_by_name_and_make_id(name: "e90 M3 Sedan", make_id: make.id)
model1 = Model.find_or_create_by_name_and_make_id(name: "e92 M3 Coupe", make_id: make.id)
model3 = Model.find_or_create_by_name_and_make_id(name: "e93 M3 Convertable", make_id: make.id)

color = Color.find_or_create_by_name(name:"Le Mans Blue")
Color.find_or_create_by_name(name:"Jerez Black")
Color.find_or_create_by_name(name:"Melbourne Red")
Color.find_or_create_by_name(name:"Mineral White")
Color.find_or_create_by_name(name:"Space Gray")
Color.find_or_create_by_name(name:"Silverstone")
Color.find_or_create_by_name(name:"Interlagos Blue")
Color.find_or_create_by_name(name:"Jet Black")
Color.find_or_create_by_name(name:"Alpine White")
Color.find_or_create_by_name(name:"Laguna Seca Blue")
Color.find_or_create_by_name(name:"Brilliant White")
Color.find_or_create_by_name(name:"Dakar Yellow II")
Color.find_or_create_by_name(name:"Azurite Black")
Color.find_or_create_by_name(name:"Moonstone")
Color.find_or_create_by_name(name:"Atlantis")
Color.find_or_create_by_name(name:"Black Sapphire")
Color.find_or_create_by_name(name:"Ruby Black")
Color.find_or_create_by_name(name:"Frozen Grey")
Color.find_or_create_by_name(name:"Monte Carlo Blue")
Color.find_or_create_by_name(name:"Frozen Black")
Color.find_or_create_by_name(name:"Phoenix Yellow")
Color.find_or_create_by_name(name:"Titanium Silver")
Color.find_or_create_by_name(name:"Hellrot")
Color.find_or_create_by_name(name:"Power Green")
Color.find_or_create_by_name(name:"Mineral White")
Color.find_or_create_by_name(name:"Marrakesh Brown")
Color.find_or_create_by_name(name:"Barbera Red")
Color.find_or_create_by_name(name:"Midnight Blue")
Color.find_or_create_by_name(name:"Santorini Blue")

# mike = User.create(username:"mikesilvis", password: "michael", email:"mikesilvis@gmail.com")
# Garage.create(model: model1, color: color, year: 2011, user: mike)