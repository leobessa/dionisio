class FriendshipsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Amigo adicionado a sua lista de amigos."
      redirect_to :back
    else
      flash[:error] = "Não foi possível adicionar."
      redirect_to :back
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Amizade removida."
    redirect_to current_user
  end
end
