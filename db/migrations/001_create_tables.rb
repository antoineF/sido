class CreateProjects < Sequel::Migration
  
  def up
    create_table :projects do
      primary_key :id
      string :name
      timestamp :last_update
      index :name
    end
    
    create_table :downloads do
      primary_key :id
      foreign_key :project_id, :type => :Integer
      string :version
      date :date
      Integer :count
    end
    
    create_table :events do
      primary_key :id
      foreign_key :project_id, :type => :Integer
      date :date
      string :name
    end
    
  end
  
  def down
    drop_table :projects 
    drop_table :downloads 
    drop_table :events 
  end
end