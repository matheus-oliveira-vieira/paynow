class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company
    else
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to @company
    else
      render :edit
    end
  end

  def refresh_token
    @company = Company.find(params[:company_id])
    if @company.refresh_token!
      redirect_to @company, notice: 'Token atualizado com sucesso'
    else
      render :show, notice: 'Erro ao atualizar o Token'
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :cnpj, :address, :email)
  end
end
