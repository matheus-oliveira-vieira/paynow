class Api::V1::ClientsController < ActionController::API
  def index
    @clients = Client.all
    render json: @clients
      .as_json(except: [:id, :created_at, :updated_at])
  end

  def generate_token
    @client = Client.find_by!(params[:client_id])
    if @client.token.blank?
      @client.token = Client.generate_token
      #byebug
      @client.update!(client_params)
      render json: @client.as_json(except: [:id, :created_at, :updated_at])
    else
      render json: {status: "error", code: 3000, message: "Token already provided"}
    end
  end

  private
  def client_params
    params.permit(:name, :cpf, :token)
  end
end