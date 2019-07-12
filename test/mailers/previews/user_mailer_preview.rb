class UserMailerPreview < ActionMailer::Preview
  def order_info_email(order)
    UserMailer.order_info_email(@order).deliver_later
  end
end