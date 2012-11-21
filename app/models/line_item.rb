class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id
  belongs_to :product_id
  belongs_to :cart

  def create
  	@cart = current_cart
  	product = Product.find(params[:product_id])
  	@line_item = @cart.line_item.build(product: product)

  	respond_to do |format|
  		if @line_item.save
  			format.html {
  				redirect_to @line_item.cart,
  				notice: 'Line item was successfully created.'
  			}
  			format.json {
  				render json: @line_item,
  				status: :created, location: @line_item
  			}
  		else
  			format.html {
  				render action: "new"
  			}
  			format.json {
  				render json: @line_item.errors,
  				status: :unprocessable_entity
  			}
  		end
  	end
end
