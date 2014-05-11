require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

change = 0
hash = {'key'=>"value"}
total_amount = 0
quan = 0
quantity = 0

get '/' do
  @products = Item.all.sort_by{rand}.slice(0,10)
  erb :index
end


get '/about' do
  erb :about
end

get '/products' do
  @products = Item.all
  erb :products
end

get '/sell_form/:id' do
  @product = Item.find(params[:id])
  quan = params[:quan].to_i
  @quan = quan
  quantity = @product.quantity
  @quantity = quantity
  erb :sell_form
end

get '/money_form/:id' do
  @product = Item.find(params[:id])
  quan = params[:quan].to_i
  @quan = quan
  total_amount = @product.price.to_i * @quan
  @total_amount = total_amount
  erb :money_form
end

post '/money_form/:id' do
  @product = Item.find(params[:id])
  @quan = quan
  quantity = @product.quantity
  @quantity = quantity
  @total_amount = @product.price.to_i * @quan
  changer = MoneyCalculator.new params[:one], params[:five], 
                            params[:ten], params[:twenty], params[:fifty], 
                            params[:hundred], params[:five_hundred], params[:thousand]
  @total_payment = changer.payment
  changer.get_change(@total_amount)
  change = @total_payment - @total_amount
  @change = change
  hash = changer.bills
  @hash = hash

  if @change < 0
    @message = "Not enough cash"
    erb :money_form

  else
    @product.update_attributes!(quantity: @product.quantity.to_i - @quan, sold: @product.sold.to_i + @quan)
    erb :money_change
  end
end

# ROUTES FOR ADMIN SECTION
# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION
