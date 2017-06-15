class ShippingAddressesController < ApplicationController

def show
  @order = current_user.orders.pending.first
end

def update
end

end
