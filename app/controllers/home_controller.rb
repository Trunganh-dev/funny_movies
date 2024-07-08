class HomeController < ApplicationController
  before_action :authenticate_user!, only: :share

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    @movies = Movie.page(page).per(per_page)
  end
end
