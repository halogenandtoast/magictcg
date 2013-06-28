class DashboardsController < ApplicationController
  def show
    @collecting_sets = current_user.collecting_sets
  end
end
