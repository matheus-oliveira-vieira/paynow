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
    @discount = Discount.new(discount_params)
    @discount.company_id = params[:company_id]
    @discount.payment_method_id = params[:payment_method_id]
    if @discount.save
      #byebug
      redirect_to company_payment_method_discount_path(params[:company_id], params[:payment_method_id], @discount)
    else
      @payment_methods = PaymentMethod.all
      render :new
    end
  end
  private
  def discount_params
    params.require(:discount).permit(:discount_percentage)
  end
end