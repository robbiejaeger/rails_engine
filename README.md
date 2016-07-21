# Rail Engine README

## About
Rails engine is a business analytics API. It uses a postgres database to store business information like: customers, merchants, items, invoices, invoice items, and transactions. You can hit certain endpoints to retrieve data in JSON format. For example, a GET request to the endpoint

```
/api/v1/merchants
```
returns all of the merchants in the database using JSON:

``` json
[
  {
    "id":1,
    "name":"Schroeder-Jerde"
  },
  {
    "id":2,
    "name":"Klein, Rempel and Jones"
  },
  {
    "id":3,
    "name":"Willms and Sons"
  }
]
```

Also, the endpoints

```
/api/v1/merchants/:id/revenue
```
returns the revenue for a specific merchant, denoted by the merchant's id.


## Setup Instructions

To clone this repository, use this command in your terminal:
```
git clone https://github.com/robbiejaeger/rails_engine.git
```
Go into the rails_engine directory and bundle.
```
bundle
```
Setup the database.
```
rails db:create db:migrate
```
Seed the database with CSV data using a rake task.
```
rake import_csv:create_all
```
Run the test suite using Rspec.
```
rspec
```
