class ShippingAddress < ApplicationRecord
  belongs_to :order

  ALLOWED_STATES = ["AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID", "IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY", "OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]

  validates :state, :inclusion => { :in => ALLOWED_STATES }

  def self.list_of_allowed_states
    ALLOWED_STATES
  end

  def display_string
    "#{first_name} #{last_name}
    #{street_address_1} #{street_address_2}
    #{city} #{state} #{zip_code}"
  end

end
