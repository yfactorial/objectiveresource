# Populates the Database with 20 dog names

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    [Person,Dog].each(&:delete_all)
    index = 1
    Person.populate 3 do |person|
      person.id = index
      person.name = Faker::Name.name
      Dog.populate 20 do |dog|
        dog.name = Faker::Name.name
        dog.person_id = person.id
      end
      index += 1
    end
  end
end