# Create Users
5.times do 
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Pokemon.name
  )
end
users = User.all

# Create Wikis
15.times do
  Wiki.create!(
  title: Faker::RickAndMorty.unique.character,
  body: Faker::RickAndMorty.unique.quote
  )
end
wikis = Wiki.all

# Create an admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  role: 'admin'
)

# Create a standard user
standard = User.create!(
  email: 'standard@example.com',
  password: 'password',
  role: 'standard'
) 

# Create a premium user
premium = User.create!(
  email: 'premium@example.com',
  password: 'password',
  role: 'premium'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
