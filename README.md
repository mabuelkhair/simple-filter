##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.7.0]
- Rails [6.0.2]

##### 1. Check out the repository

```bash
git clone https://github.com/mabuelkhair/trufla-backend.git
```

##### 2. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:setup
```

##### 3. Start the Rails server

You can start the rails server using the command given below.
Please note the port is changed here because the frontend is using same port

```ruby
rails s -p 8000
```

And now you can use the APIs using this URL http://localhost:8000

**API Examples**

Get first page of products
```
http://localhost:8000/products
```
get products in 2 departments 7 and 9
```
http://localhost:8000/products?department_ids[]=7&department_ids[]=9

```
get products with promocode act25
```
http://localhost:8000/products?code=act25

```

##### 4. To Run Test

Just run this command to check run tests

```ruby
rails test
```
