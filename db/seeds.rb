# User.create!(name:  "Example User",
# email: "example@magicalwardrobeapp.com",
# password:              "123456",
# password_confirmation: "123456",
# admin: true,
# activated: true,
# zip_code: 37013,
# activated_at: Time.zone.now)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@magicalwardrobeapp.com"
password = "password"
zip_code = Faker::Address.zip_code
User.create!(
  name:                  name,
  email:                 email,
  password:              password,
  password_confirmation: password,
  activated: true,
  zip_code:              zip_code,
  activated_at: Time.zone.now)
end

    TopType.create!([
      {name: "Sweater", description: "An article that is worn over a shirt"},
      {name: "Hoodie", description: "Any top with a hood"},
      {name: "T-shirt", description: "With sleeve, either half or full"},
      {name: "Blouse", description: "A shirt that is worn with dressy attire"},
      {name: "Dress Shirt", description: "A button-down or collared shirt"},
      {name: "Tank Top", description: "Sleeveless, maybe just strap over shoulder"}
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
      {name: "Jewelry"},
      {name: "Coats"},
      {name: "Jackets"}
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

    







