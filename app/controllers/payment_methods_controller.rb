class PaymentMethodsController < ApplicationController
  def index
    @payment_method = PaymentMethod.all
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
  end

  def new
    @payments = Payment.all
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    @payment_method.company_id = params[:company_id]
    if @payment_method.save
      # byebug
      redirect_to company_payment_method_path(params[:company_id],
                                              @payment_method)
    else
      @payment = Payment.all
      render :new
    end
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:payment_id, :code, :agency,
                                           :bank_account)
  end
end
