class LikesController < ApplicationController
before_action :find_bet
before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @bet.likes.create(user_id: current_user.id)
    end
      redirect_to bet_path(@bet)
  end

  def destroy
    if !already_liked?
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to bet_path(@bet)
  end

  private

  def find_bet
    @bet = Bet.find(params[:bet_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:bet_id]).exists?
  end

  def find_like
    @like = @bet.likes.find(params[:id])
  end

end
