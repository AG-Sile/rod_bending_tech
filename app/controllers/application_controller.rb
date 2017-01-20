class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def home
      render html: "Welcome to Rod Bending Technology!"
  end
  
  def about
    render html "Here you can learn all about RBT"
  end
end
