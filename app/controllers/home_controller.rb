# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, only: :share

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 5

    @movies = Movie.page(page).per(per_page)
  end

  def share
  end
end
