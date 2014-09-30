class ActionColorsController < ApplicationController

  def index
    @actions = ActionColor.recents
  end

  def show
    flash[:error] = "Ação não permitida"
    redirect_to action: :index
  end

  def new
    @action = ActionColor.new
  end

  def edit
    @action = ActionColor.find(params[:id])
  end

  def create
    params.permit!

    @action = ActionColor.new(params[:action_color])
    params[:color].each { |color| @action.colors << Color.new(color)  }

    if @action.save
      flash[:success] = "Registro Cadastrado com Sucesso"
      redirect_to action: :index
    else
      flash[:error] = "Registro com erros"
      render "new"
    end
  end

  def update
    @action = ActionColor.find(params[:id])
    params.permit!

    if @action.update_attributes(params[:action_color])
      params[:color].each do |color|
        cor = Color.find(color[:id])

        cor.on     = false unless color[:on]
        cor.alert  = false unless color[:alert]

        if !cor.update_attributes(color)
          flash[:error] = "Registro com erros"
          render "update"
        end
      end

      flash[:success] = "Registro Alterado com Sucesso"
      redirect_to action: :index
    else
      flash[:error] = "Registro com erros"
      render "update"
    end
  end

  def destroy
    @action = ActionColor.find(params[:id])

    if @action.delete
      flash[:success] = "Registro Excluído com Sucesso"
    else
      flash[:error] = "Impossível Excluir o registro"
    end

    redirect_to action: :index
  end
end
