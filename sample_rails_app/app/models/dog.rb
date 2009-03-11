class Dog < ActiveRecord::Base
  belongs_to :person
  validates_exclusion_of :name, :in => ["ReservedName"]
end
