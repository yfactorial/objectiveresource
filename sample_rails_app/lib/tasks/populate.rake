# Populates the Database with 20 dog names

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Dog].each(&:delete_all)
    
    Dog.populate 100 do |dog|
      dog.name = Faker::Name.name
    end
  end
end