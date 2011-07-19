class AddColumns < Sequel::Migration
  def up
    add_column :projects, :downloads_count, :Integer, :default => 0
  end
 
  def self.down
    remove_column :projects, :downloads_count
  end
end