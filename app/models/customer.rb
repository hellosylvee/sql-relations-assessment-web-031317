class Customer
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    birth_year: "INTEGER",
    hometown: "TEXT"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def reviews
    sql = <<~SQL
      SELECT * FROM customer_reviews_id
      INNER JOIN customers ON customers.customer_reviews_id = customer_reviews.id
      INNER JOIN customer_reviews ON customer_reviews.reviews_id = reviews.id
    SQL
    self.class.db.execute(sql, self.reviews_id)
  end

  def restaurants
    sql = <<-SQL
      SELECT restaurants.* FROM restaurants
      INNER JOIN reviews ON reviews.restaurant_id = restaurants.id
      WHERE reviews.customer_id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end
