# frozen_string_literal: true

# app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  before_action :authenticate_user!

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build
    handle_params(@movie, normalize_parameters)
    if @movie.save
      ActionCable.server.broadcast('notification_channel',
                                   { message: "A new video has been shared by #{current_user.email}: #{@movie.title}" })
      redirect_to root_path, notice: I18n.t('notices.share_success')
    else
      redirect_to new_movie_path, alert: @movie.errors.full_messages.join(', ')
    end
  rescue VideoInfo::UrlError
    redirect_to new_movie_path, alert: I18n.t('notices.invalid_url')
  rescue StandardError => e
    logger.error e.message
    logger.error e.backtrace.join("\n")
    redirect_to new_movie_path, alert: I18n.t('notices.general_error')
  end

  private

    def normalize_parameters
      params.require(:movie).permit(:url)
    end

    def handle_params(record, params)
      video = VideoInfo.new(params[:url])

      record.assign_attributes({
                                 title: video.title,
                                 description: video.description,
                                 thumb_url: video.thumbnail_medium,
                                 video_id: video.video_id
                               })
    end
end
