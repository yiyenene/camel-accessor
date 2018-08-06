require "active_record"

ActiveRecord::Base.configurations = { "test" => { adapter: "sqlite3", database: ":memory:" } }
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :test_value
      t.integer :value2
    end

    create_table(:books) do |t|
      t.string :random_code
      t.string :registration_number
    end

    create_table(:drinks) do |t|
      t.string :type_id
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up
