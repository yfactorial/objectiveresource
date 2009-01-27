class AddPeopleToDogs < ActiveRecord::Migration
  def self.up
    add_column :dogs, :person_id, :integer
  end

  def self.down
    remove_column :dogs, :person_id
  end
end
