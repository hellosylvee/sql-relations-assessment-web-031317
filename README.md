# SQL Assessment

For this assessment, pretend we now have a totally different website from the object relations section.
Please don't base your answers on your Ruby work.

Here, we have a different Yelp-style application. We need customers, restaurants, owners, and reviews.  How do they link up?

## Topics / Objectives

+ Domain modeling
+ has_many / belongs_to relationships
+ SQL `Select` statements
+ SQL Joins

### Deliverables

1. As a first step, please write out the domain model in this file
   + What we are concerned about is which tables have foreign keys
   + Don't stress: There may be multiple correct answers based on your conception of the problem.

   Eg. for our books and authors your deliverable would look like

    ### books
    id | title | author_id

    ### author
    id | name |

2. As a second step, please fill in the stubbed out methods in the respective model. The important thing here is to know what SQL will fire to select the data you're looking for. For example, if I want a method called 'author' for my `Book` class, it might look something like this.

```ruby
class Book
  include Databaseable::InstanceMethods # Access to our database
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    title: "TEXT",
    release_year: "INTEGER"
   }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def author
    sql = <<-SQL
    SELECT * FROM authors
    WHERE id = ?
    SQL
    self.class.db.execute(sql, self.author_id)
  end

end

```
  - Customer#reviews
    - returns all of the reviews written by that customer
  - Owner#restaurants
    - returns all restaurants belonging to that owner
  - Restaurant#owner
    - returns the owner of that restaurant
  - Review#customer
    - returns the customer of that review
  - Review#restaurant
    - returns the restaurant of that particular review


#### Hints:
  - The data always lives on the belongs_to relationship
  - Do the belongs_to first, then do the has_many
  - If there is a many to many, we need a third table
  - We've provided you with a `console.rb` file and a `seed.rb` file. You can run `ruby tools/seed.rb` to add some data to your database, and then `ruby tools/console.rb` to interact with your Ruby classes.


#### Write your domain model here:
    ### restaurants
    id | name | location | owner_id

    ### owners
    id | name |

    ### customers
    id | name | birth_year | hometown

    ### reviews
    id | name | restaurant_id | customer_id
