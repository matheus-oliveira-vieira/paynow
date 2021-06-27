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
    
    if @charge.update(charge_params) && @charge.status == 'aprovada'
      @charge.payment_confirmation = @charge.payment_method.send_payment_confirmation
      @charge.update(charge_params)
      redirect_to charge_path(@charge)
    elsif @charge.update(charge_params) && @charge.status == 'pendente'
      redirect_to root_path
    else
      render :edit
    end
  end

  def search
    @charges = Charge.where('expiration_date like ?',"%#{params[:q]}%")
    #byebug
  end

  private

  def charge_params
    params
      .require(:charge)
      .permit(:company_id, :product_id, :payment_method_id, :client_id, :discount_id,
              :card_name, :card_number, :card_code, :original_price, :payment_confirmation, :new_price, :status, :boleto_address, :date_payment, :expiration_date, :bank_code_error)
  end

end