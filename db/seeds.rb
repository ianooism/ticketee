=begin
2.times do |i|
  @project = Project.create(name: "Project#{i+1}", description: 'project description')
  2.times do |j|
    @project.tickets.create!(name: "Ticket#{j+1}", description: 'ticket description', author_id: '1')
  end
end
=end

#User.create!(full_name: 'A A', email: 'a@a', password: 'aaaaaa')

#State.create!([{name: 'New', default: true}, {name: 'Open'}, {name: 'Closed'}])
