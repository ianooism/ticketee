# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
3.times do |i|
  Project.create(name: "Project #{i+1}", description: "Description for Project #{i+1}")
end
=end

=begin
3.times do |i|
  3.times do |j|
    Project.find_by(name: "Project #{i+1}").tickets.create(name: "Ticket #{j+1}", description: "Description for Ticket #{j+1}")
  end
end
=end
