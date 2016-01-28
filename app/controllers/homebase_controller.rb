class HomebaseController < ApplicationController
  def index
  #  @show_map = false
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
