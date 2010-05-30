class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :author, :null => false
      t.string :words, :limit => 100, :null => false
      t.string :media1, :limit => 75
      t.string :media2, :limit => 75
      t.string :media3, :limit => 75
      t.string :media4, :limit => 75
      t.string :media5, :limit => 75
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
