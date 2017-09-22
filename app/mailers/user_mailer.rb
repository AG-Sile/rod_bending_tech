class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

  def order_confirmation(user)
    @user = user
    mail to: user.email, subject: "Your order has been placed"
  end

  def order_placed
    mail to: ENV['SELLER_EMAIL'], subject: "An order has been placed"
  end
end
