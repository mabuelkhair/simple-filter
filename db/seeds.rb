# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.delete_all
Department.delete_all
Promotion.delete_all
ProductsPromotions.delete_all

d1 = Department.create(name: 'Electronics')
d2 = Department.create(name: 'Sports')
d3 = Department.create(name: 'Toys')
departments = [d1, d2, d3]
names = ['Electronics', 'Sports', 'Toys']
counter = 1 
products = []
while counter <= 20
	idx = rand(0..2)
	price = rand(10.0..500.0).truncate(2)
	product = Product.create(name: "#{names[idx]}_#{counter}", department: departments[idx], price: price)
	products.append(product)
	counter += 1
end
active_promotion = Promotion.create(active: true, code: 'act25', discount: 25.0)
inactive_promotion = Promotion.create(active: false, code: 'pro30', discount: 25.0)

active_promotion.products << products[0]
active_promotion.products << products[10]
active_promotion.products << products[18]
inactive_promotion.products << products[3]
inactive_promotion.products << products[13]
inactive_promotion.products << products[17]
active_promotion.save
inactive_promotion.save

