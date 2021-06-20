class PaymentMethodsController < ApplicationController
  def index
    @payment_method = PaymentMethod.all
  end

  def new
    @payment = Payment.all
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = JobApplication.new
    @payment_method.company_id = params[:company_id]
    if @payment_method.save
      redirect_to company_path
    else
      redirect_to root_path
    end
  end
end