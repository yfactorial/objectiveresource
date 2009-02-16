class AddSomeIntegerAndSomeDecimalToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :some_integer, :integer
    add_column :people, :some_decimal, :decimal
  end

  def self.down
    remove_column :people, :some_decimal
    remove_column :people, :some_integer
  end
end
