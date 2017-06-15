require 'shippo'

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_variant

  composed_of :individual_price,
              :class_name => 'Money',
              :mapping => %w(individual_price cents),
              :converter => Proc.new { |value| value.to_money }

  #TODO: this should be a config
  def origin
    {
      :name => 'Rod Bending Technology',
      :street1 => '4006 N McVicker Ave Apt 3C',
      :city => 'Chicago',
      :state => 'IL',
      :zip => '60634',
      :country => 'US',
      :phone => '+1 773 449 2625',
      :email => 'support@rbtfishing.com'
    }
  end

  def destination
    address = order.shipping_addresses.first
    { name: address.first_name + address.last_name,
      street1: address.street_address_1,
      street2: address.street_address_2,
      city: address.city,
      zip: address.zip_code,
      state: address.state,
      country: address.country,
      email: order.user.email,
      validate: true
    }
  end

  def package
    pv = product_variant
    weight = pv.weight_pounds * 16 + pv.weight_ounces
    {
      length: pv.length,
      width: pv.width,
      height: pv.height,
      distance_unit: :in,
      weight: weight,
      mass_unit: :oz,
    }
  end

  def shipping_rates
    binding.pry
    Shippo::Shipment.create(
      :address_from => origin,
      :address_to => destination,
      :parcels => package,
      :async => false
    )
  end

end
