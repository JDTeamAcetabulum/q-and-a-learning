# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a typical user with the given name/role and a default password
def my_user(name, role)
  {username: name, email: "#{name}@gatech.edu", password: '123123', role: role}
end

User.create((1..3).to_a.map do |i|
  my_user("i#{i}", 'instructor')
end)

User.create((1..20).to_a.map do |i|
  my_user("s#{i}", 'student')
end)
