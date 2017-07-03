class ShippingAddressesController < ApplicationController

  def new
    if logged_in?
      @order = current_user.carts.shopping_cart.first.convert_to_order
      @shipping_address = @order.shipping_addresses.create
    else
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def create
    if address_params.any?
      @order = current_user.carts.shopping_cart.first.convert_to_order
      @order.shipping_addresses.map(&:destroy)
      if address_params[:address] == "new_address"
        if new_address_params[:remember] == "1"
          current_user.user_addresses.create(new_address_params.except(:remember))
        end
        address_fields = new_address_params
      else
        existing_address = UserAddress.find_by(id: address_params[:address].split("_").last.to_i)
        address_fields = existing_address.address_fields
      end
      @order.shipping_addresses.create(address_fields)
      redirect_to check_out_2_path
    else
      flash[:danger] = "Please select an address"
      redirect_to check_out_1_path
    end
  end

  private
    def address_params
      params.permit(:address)
    end

    def new_address_params
      params.require(:shipping_address).permit(
        :first_name,
        :last_name,
        :street_address_1,
        :street_address_2,
        :city,
        :zip_code,
        :state,
        :remember
      )
    end

end
