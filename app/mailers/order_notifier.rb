class OrderNotifier < ApplicationMailer
  default from: 'Sam Ruby <trangtranuitk8@gmail.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    # @greeting = "Hi"

    # mail to: "trang120512@gmail.com"

    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    # @greeting = "Hi"

    @order = order
mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
