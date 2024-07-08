class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = current_user.votes.new(normalize_parameters)

    if @vote.save
      redirect_to root_path, notice: "Vote Success"

      return
    end

    redirect_to root_path, alert: @vote.errors.full_messages
  end

  def destroy
    @vote = current_user.votes.find_by_id params[:id]

    if @vote.destroy
      redirect_to root_path, notice: "Unvote Success"

      return
    end

    redirect_to root_path, alert: @vote.errors.full_messages
  end

  private

  def normalize_parameters
    params.require(:vote).permit(:movie_id, :vote_type)
  end
end
