class Api::V1::ChargesController < ActionController::API
  def create
    @charge = Charge.new(charge_params)
    if @charge.save!
      byebug
      render json: @charge, status: :created
    else
      render json: {status: "error", code: 3000, message: "Error on create charge"}
    end
  rescue ActionController::ParameterMissing
    render status: :precondition_failed, json: { errors: 'parâmetros inválidos' }
  end

  private

  def charge_params
    params
      .require(:charge)
      .permit(:company_id, :product_id, :payment_method_id, :client_id, :discount_id,
              :card_name, :card_number, :card_code, :original_price, :new_price, :status, :boleto_address)
  end
end