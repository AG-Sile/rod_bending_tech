module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
    merge_carts
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Return currently logged in user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    cookies[:cart_id] = nil
    session.delete(:cart_id)
    @current_user = nil
    @session_cart = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def session_cart
    @session_cart ?  @session_cart : session_cart!
  end

  # use this method if you want to force a SQL query to get the cart.
  def session_cart!
    if !cookies[:cart_id].blank?
      @session_cart = Cart.includes(:cart_items).find_by_id(cookies[:cart_id])
      unless @session_cart
        @session_cart = Cart.create!(:user_uuid => current_user.uuid, cart_type: 'shopping_cart')
        cookies[:cart_id] = @session_cart.id
      end
    elsif current_user
      @session_cart = current_user.carts.shopping_cart.last || current_user.carts.create!(cart_type: 'shopping_cart')
      cookies[:cart_id] = @session_cart.id
    else
      @session_cart = Cart.create!(cart_type: 'shopping_cart')
      cookies[:cart_id] = @session_cart.id
    end
    @session_cart
  end

  def merge_carts
    if !!current_user
      @session_cart = session_cart.merge_with_previous_cart!(current_user)
      cookies[:cart_id] = @session_cart.id
    end
  end

  def set_user_to_cart_items(user)
    if session_cart.user_id != user.id
      session_cart.update_attribute(:user_id, user.id )
    end
    session_cart.cart_items.each do |item|
      item.update_attribute(:user_id, user.id ) if item.user_id != user.id
    end
  end
end
