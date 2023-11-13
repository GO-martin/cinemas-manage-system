class PaymentIntentsController < ApplicationController
  def create
    payment_intent = Stripe::PaymentIntent.create(
      amount: params[:amount].to_i,
      currency: params[:currency],
      description: 'Order for RetroCinema'
    )
    render json: {
      id: payment_intent.id,
      client_secret: payment_intent.client_secret
    }
  end
end
