class Download < Sequel::Model
  many_to_one :project
  
  def increment
    self.update(:count => self.count+1)
  end
end