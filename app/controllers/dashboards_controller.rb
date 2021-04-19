class DashboardsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @athletes = pagy(User.all, items: 9)
  end

  def search
    @search_name = params[:search_name]
    @pagy, @athletes = pagy(User.search(@search_name), items: 9)
    render :index
  end
end
