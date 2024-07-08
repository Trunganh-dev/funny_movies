# app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  before_action :authenticate_user!

  def new
    @movie = Movie.new
  end

  def create
    begin
      @movie = current_user.movies.build
      handle_params(@movie, normalize_parameters)
      if @movie.save!
        ActionCable.server.broadcast('notification_channel', { message: "A new video has been shared: #{@movie.title}" })
        return redirect_to root_path, notice: "Share success"
      end

      redirect_to new_movie_path, alert: "Share video Error"
    rescue VideoInfo::UrlError
      redirect_to new_movie_path, alert: "Invalid URL or unsupported video provider"
    rescue StandardError => e
      logger.error e.message
      logger.error e.backtrace.join("\n")
      redirect_to new_movie_path, alert: "An error occurred while sharing the video"
    end
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
