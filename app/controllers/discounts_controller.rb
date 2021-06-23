class DiscountsController < ApplicationController
  def index
    @discount = Discount.all
  end
  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @payment_methods = PaymentMethod.all
    @discount = Discount.new
  end

  def create
    @discount = Discount.new(payment_method_params)
    @discount.product_id = params[:product_id]
    if @payment_method.save
      #byebug
      redirect_to company_payment_method_path(params[:company_id], @payment_method)
    else
      @payment = Payment.all
      render :new
    end
  end
  private
  def payment_method_params
    params.require(:payment_method).permit(:payment_id, :code, :agency, :bank_account)
  end
end