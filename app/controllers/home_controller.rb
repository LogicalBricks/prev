class HomeController < ApplicationController
  def index
    @prevision = Prevision.first
    render :blank unless @prevision
  end
end
