class HexagonsController < ApplicationController
  def show
    @hexagon = Hexagon.find(params[:id])
  end

  #def new
    #@user = User.find(params[:user_id])
    #@hexagon = Hexagon.current_user.build_hexagon
  #end

  def create
    @user = User.find(params[:user_id])
    @hexagon = current_user.build_hexagon(hexagon_params)

      @hexagon.save
      flash[:success] = 'グラフを設定しました'
      redirect_to @user
  end

  def edit
    @evaluated_user = Evaluated_user.find(params[:user_id])
    @hexagon = @evaluated_user.hexagon
  end

  def update
    @evaluated_user = Evaluated_user.find(params[:user_id])
    @hexagon = @evaluated_user.hexagon

    if @hexagon.update(hexagon_params)
      flash[:success] = 'グラフに投票されました'
      redirect_to @user
    else
      flash.now[:danger] = 'グラフの投票に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def hexagon_params
    params.require(:hexagon).permit(:pass, :dribble, :shoot, :body_control, :judgement, :speed)
  end
end
