class DashboardsController < ApplicationController
  def show
    @collecting_sets = current_user.collecting_sets
    @uncollecting_sets = CardSet.where.not(id: @collecting_sets.map(&:card_set_id))
  end
end
