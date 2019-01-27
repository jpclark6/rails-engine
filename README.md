# Rails Engine API

This is a JSON API I built in rails that exposes a SalesEngine database scheme, along with some statistics and relationships. All tables can be called, along with find by parameters, and find all by parameters, along with business intelligence for the top merchants by revenue, most items sold by revenue, total revenue on a given date, invidivdual merchant data for revenue, revenue on a date, and a favorite customer by revenue, along with the most revenue items, most items sold by quantity, the best day for an item based on revenue, and finally a customer's favorite merchant.

It adheres to [this](https://jsonapi.org/) JSON spec for formatting data.

Here is a sample return when you call '/api/v1/items/most_items?quantity=3' to get the top 3 items by revenue.

```
{
  "data": [
    {
      "id": "227",
      "type": "item",
      "attributes": {
        "id": 227,
        "name": "Item Dicta Autem",
        "description": "Fugiat est ut eum impedit vel et. Deleniti quia debitis similique. Sint atque explicabo similique est. Iste fugit quis voluptas. Rerum ut harum sed fugiat eveniet ullam ut.",
        "merchant_id": 14,
        "unit_price": "853.19"
      }
    },
    {
      "id": "2174",
      "type": "item",
      "attributes": {
        "id": 2174,
        "name": "Item Nam Magnam",
        "description": "Eligendi quibusdam eveniet temporibus sed ratione ut magnam. Sit alias et. Laborum dignissimos quos impedit excepturi molestiae.",
        "merchant_id": 89,
        "unit_price": "788.08"
      }
    },
    {
      "id": "2175",
      "type": "item",
      "attributes": {
        "id": 2175,
        "name": "Item Delectus Saepe",
        "description": "Pariatur voluptatum at qui. Quisquam illo aspernatur. Repellat provident nemo vero quis ut enim. Voluptates et sint laborum. Magnam ut deleniti aliquam.",
        "merchant_id": 89,
        "unit_price": "415.29"
      }
    }
  ]
}
```

It also uses a custom rake task to load sample csv data. The tables in the database are for customers, merchants, items, invoices, invoice items, and transactions.

## Ruby and Rails Versions

This was built using Ruby version 2.4.1 and Rails 5.2.2. Make sure the directory is using these versions to ensure the app runs correctly.

## Database

It uses a PostgreSQL database. All testing is done in the testing database with fresh data populated before each test, and a database wipe after each test to ensure the correct test results.

## Configuration

After forking and cloning the repository into a selected directory enter the following commands into the terminal to get set up.

```
bundle
rake db:{create,migrate}
rake load_csv
rails s
```
The server should now be running and be ready for API calls.

## Routes

If the server started up correctly you should now be able to make API calls using the following routes:

```
/api/v1/customers
/api/v1/customers/find?attribute=value
/api/v1/customers/find_all?attribute=value
/api/v1/customers/random
/api/v1/customers/:id
/api/v1/customers/:id/invoices
/api/v1/customers/:id/favorite_merchant
/api/v1/customers/:id/transaction

/api/v1/merchants
/api/v1/merchants/find?attribute=value
/api/v1/merchants/find_all?attribute=value
/api/v1/merchants/most_revenue
/api/v1/merchants/most_items
/api/v1/merchants/revenue
/api/v1/merchants/:id
/api/v1/merchants/:id/revenue
/api/v1/merchants/:id/favorite_customer
/api/v1/merchants/:id/items
/api/v1/merchants/:id/invoices
/api/v1/merchants/:id/customers_pending_invoices

/api/v1/invoices
/api/v1/invoices/find?attribute=value
/api/v1/invoices/find_all?attribute=value
/api/v1/invoices/:id/transactions
/api/v1/invoices/:id/invoice_items
/api/v1/invoices/:id/items
/api/v1/invoices/:id/customer
/api/v1/invoices/:id/merchant
/api/v1/invoices/:id

/api/v1/invoice_items
/api/v1/invoice_items/find?attribute=value
/api/v1/invoice_items/find_all?attribute=value
/api/v1/invoice_items/:id/item
/api/v1/invoice_items/:id/invoice
/api/v1/invoice_items/random
/api/v1/invoice_items/:id

/api/v1/items
/api/v1/items/find?attribute=value
/api/v1/items/find_all?attribute=value
/api/v1/items/most_revenue
/api/v1/items/most_items
/api/v1/items/:id/invoice_items
/api/v1/items/:id/merchant
/api/v1/items/:id/best_day
/api/v1/items/:id

/api/v1/transactions
/api/v1/transactions/find?attribute=value
/api/v1/transactions/find_all?attribute=value
/api/v1/transactions/:id
/api/v1/transactions/:id/invoice
```
Some sample attributes to pass in to the find and find_all are as follows:
```
Customer:
find?first_name=Sal
find?last_name=Roberts
find?id=5

Item:
find_all?unit_price=30.55
find_all?merchant_id=84
find_all?created_at=2018-04-28

Transaction:
find_all?credit_card_number=4823174638237372
find_all?result=success
```

# Testing

This app was created using TDD and uses the test suite [rspec](http://rspec.info/). To run the tests use the following terminal command:

``` rspec ```

It currently has 95%+ testing coverage on both model and request levels.

It also takes advantage of the testing data creation library [factory bot](https://github.com/thoughtbot/factory_bot) to easily create objects in the testing database to help with model and route testing.
