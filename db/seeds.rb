# User.create!(name:  "Example User",
# email: "example@magicalwardrobeapp.com",
# password:              "123456",
# password_confirmation: "123456",
# admin: true,
# activated: true,
# family_id: 0,
# zip_code: 37013,
# activated_at: Time.zone.now)

# 99.times do |n|
# name  = Faker::Name.name
# email = "example-#{n+1}@magicalwardrobeapp.com"
# password = "password"
# zip_code = Faker::Address.zip_code
# User.create!(
#   name:                  name,
#   email:                 email,
#   password:              password,
#   password_confirmation: password,
#   family_id:                  0,
#   activated: true,
#   zip_code:              zip_code,
#   activated_at: Time.zone.now)
# end

    TopType.create!([
      {name: "Sweater"},
      {name: "Hoodie"},
      {name: "T-shirt"},
      {name: "Blouse"},
      {name: "Dress Shirt"},
      {name: "Tank Top"}
    ])

    BottomType.create!([
      {name: "Jeans"},
      {name: "Slacks"},
      {name: "Khakis"},
      {name: "Shorts"},
      {name: "Skirts"}
    ])

    FootwearType.create!([
      {name: "Sandals"},
      {name: "Boots"},
      {name: "Sneakers"},
      {name: "Dress Shoes"}
    ])

    AccessoryType.create!([
      {name: "Umbrella"},
      {name: "Belts"},
      {name: "Jewelry"}
    ])

    OutterwearType.create!([
      {name: "Coat"},
      {name: "Jacket"},
      {name: "Button Sweater"},
      {name: "Raincoat"},
      {name: "Poncho"},
      {name: "Over Shirt"}
    ])

    StyleType.create!([
      {name: "Slumming"},
      {name: "Casual"},
      {name: "Business Casual"},
      {name: "Business Professional"},
      {name: "Any"}
    ])

    WeatherType.create!([
      {name: "Rain"},
      {name: "Sunny"},
      {name: "Snow"},
      {name: "Clear"},
      {name: "Any"}
    ])

    TemperatureType.create!([
      {name: "Cold"},
      {name: "Cool"},
      {name: "Hot"},
      {name: "Warm"},
      {name: "Any"}
    ])

   

    







