class HomebaseController < ApplicationController
  def index
    #  @show_map = false
    @memory_markers =  current_user.all_memories.map {|memory| {lat: memory.latitude, long: memory.longitude, title: memory.title}}.flatten
    @plan_markers =  current_user.all_plans.map {|plan| {lat: plan.latitude, long: plan.longitude, title: plan.title}}.flatten
    @item_markers =  current_user.all_items.map {|item| {lat: item.latitude, long: item.longitude, title: item.title}}.flatten
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_homebase
    @homebase = Homebase.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def homebase_params
    params.require(:homebase).permit(:email)
  end
end
