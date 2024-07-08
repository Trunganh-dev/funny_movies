# frozen_string_literal: true

# app/controllers/votes_controller.rb
class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = current_user.votes.new(normalize_parameters)

    if @vote.save
      redirect_to root_path, notice: I18n.t('notices.vote_success')
      return
    end

    redirect_to root_path, alert: @vote.errors.full_messages
  end

  def destroy
    @vote = current_user.votes.find_by(id: params[:id])

    if @vote.destroy
      redirect_to root_path, notice: I18n.t('notices.unvote_success')
      return
    end

    redirect_to root_path, alert: I18n.t('notices.unvote_failed')
  end

  private

    def normalize_parameters
      params.require(:vote).permit(:movie_id, :vote_type)
    end
end
