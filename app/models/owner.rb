class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def restaurants
    sql = <<~SQL
      SELECT * FROM restaurant_ownerships
      INNER JOIN owners ON owners.restaurant_ownerships_id = restaurant_ownerships.id
      INNER JOIN restaurants ON restaurant_ownerships.restaurant_id = restaurants.id
    SQL
  end
end
