class UserMailer < ApplicationMailer
    default from: 'no-reply@jungle.com'

    def order_info_email(order)
        @order = order
        mail(to: @order.email, subject: `Your Jungle order ##{@order.id}`)
    end
end
