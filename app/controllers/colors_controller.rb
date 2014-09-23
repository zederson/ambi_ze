class ColorsController < ApplicationController

  def index
    @colors = Color.recents
  end

  def new
    @color = Color.new
  end

  def create
    params.permit!
    @color = Color.new(params[:color])

    if @color.save
      flash[:success] = "Registro Cadastrado com Sucesso"
      redirect_to action: :index
    else
      flash[:error] = "Registro com erros"
      render "new"
    end
  end

  def edit
    @color = Color.find(params[:id])
  end

  def update
    @color = Color.find(params[:id])
    params.permit!

    if @color.update_attributes(params[:color])
      flash[:success] = "Registro Alterado com Sucesso"
      redirect_to action: :index
    else
      flash[:error] = "Registro com erros"
      render "update"
    end
  end

end
