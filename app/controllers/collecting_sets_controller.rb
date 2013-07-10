class CollectingSetsController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.collecting_sets
  end

  def show
    respond_with current_user.collecting_sets.find(params[:id])
  end

  def create
    respond_with current_user.collecting_sets.create(params[:collecting_set])
  end

  def update
    respond_with current_user.collecting_sets.update(params[:id], params[:card])
  end

  def destroy
    respond_with current_user.collecting_sets.destroy(params[:id])
  end
end
