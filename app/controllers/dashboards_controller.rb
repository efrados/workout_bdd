class DashboardsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @athletes = pagy(User.all, items: 9)
  end
end
