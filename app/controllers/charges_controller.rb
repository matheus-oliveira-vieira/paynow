class ChargesController < ApplicationController
  def index
    @charges = Charge.all
  end

  def show
    @charge = Charge.find(params[:id])
  end

  def new
    @charge = Charge.new
  end

  def edit
    @charge = Charge.find(params[:id])
  end

  def update
    @charge = Charge.find(params[:id])
    
    if @charge.update(charge_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def charge_params
    params
      .require(:charge)
      .permit(:company_id, :product_id, :payment_method_id, :client_id, :discount_id,
              :card_name, :card_number, :card_code, :original_price, :new_price, :status, :boleto_address, :date_payment, :bank_code_error)
  end

end