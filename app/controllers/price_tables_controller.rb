class PriceTablesController < ApplicationController
  before_action :check_admin, only: [:new, :create, :edit, :update]
  before_action :set_weight_column, only: [:edit, :update]
  before_action :weight_column_params, only: [:create, :update]
  def index
    @weight_table = WeightTable.all
  end

  def new
    @weight_column = WeightTable.new
  end

  def create
    @weight_column = WeightTable.new(weight_column_params)
    if @weight_column.save
      return redirect_to @weight_column, notice: 'Fileira Cadastrada com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @weight_column.update(weight_column_params)
      return redirect_to @weight_column, notice: 'Fileira Atualizada com sucesso.'
    else
      render :new
    end
  end

  private

  def weight_column_params
    params.require(:weight_table).permit(:min, :max, :value)
  end

  def check_admin

    if !current_user.admin
      return redirect_to root_path, notice: "Acesso negado"
    end
  end

  def set_weight_column
    @weight_column = WeightTable.find(params[:id])
  end

end

