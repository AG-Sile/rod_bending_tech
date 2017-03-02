class StaticPagesController < ApplicationController

  def home
  end

  def help
  end

  def about
  end

  def products
  end

  def letsencrypt
    render text: "#{params[:id]}.7otAJd9MSyUfvE-yWluopXs7gkPHzOUj1faEOAKn4jk"
  end
end
