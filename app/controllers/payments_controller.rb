class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @payment = Payment.new
  end

  def create
    
    @payment = Payment.new(payment_params)
    if @payment.save
      byebug
      @payment.active = true
      redirect_to @payment
    else
      render :new
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])

    if @payment.update(payment_params)
      redirect_to @payment
    else
      render :edit
    end
  end

  def activate
    @payment = Payment.find(params[:payment_id])
    if @payment.update(active: true)
      redirect_to payment_path(@payment)
    else
      render :index
    end
  end

  def inactivate
    @payment = Payment.find(params[:payment_id])
    if @payment.update(active: false)
      redirect_to payment_path(@payment)
    else
      render :index
    end
  end

  private
  def payment_params
    params.require(:payment).permit(:name, :type_payment, :fee_percentage, :max_fee, :logo, :bank_code)
  end
end