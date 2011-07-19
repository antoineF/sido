class Event < Sequel::Model
  many_to_one :project
  
end