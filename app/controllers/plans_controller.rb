class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :search, :update, :destroy]

  # GET /plans
  def index
    @plans = current_user.all_plans
    authorize :plan, :index?
    if params[:search]
      @plans = Plan.for_user(current_user).search(params[:search]).order("created_at DESC")
    else
      @plans = Plan.for_user(current_user).order("created_at DESC")
    end
    @plan_markers =  current_user.all_plans.map {|plan| {lat: plan.latitude, long: plan.longitude, title: plan.title}}.flatten
  end

  # GET /plans/1
  def show
    @plan = Plan.find(params[:id])
    authorize(@plan)
    plans = current_user.all_plans.map(&:id)
    current = plans.index(@plan.id)
    @previous = Plan.find(plans[current - 1]) unless current == 0
    @next = Plan.find(plans[current + 1]) unless current == plans.length - 1
    @plan_markers =  current_user.all_plans.map {|plan| {lat: plan.latitude, long: plan.longitude, title: plan.title}}.flatten
  end

  # GET /plans/new
  def new
    @plan = Plan.new
    authorize(@plan)
    @plan_markers =  current_user.all_plans.map {|plan| {lat: plan.latitude, long: plan.longitude, title: plan.title}}.flatten
  end

  # GET /plans/1/edit
  def edit
    authorize(@plan)
    @plan_markers =  current_user.all_plans.map {|plan| {lat: plan.latitude, long: plan.longitude, title: plan.title}}.flatten
  end

  # POST /plans
  def create
    @plan = current_user.plans.create(plan_params)
    authorize(@plan)
    @plan_markers =  current_user.all_plans.map {|plan| {lat: plan.latitude, long: plan.longitude, title: plan.title}}.flatten
    if @plan.save
      redirect_to @plan, notice: 'Plan was successfully created.'
    else
      render :new
    end
    @plan.labels = Label.update_labels(params[:plan][:labels])
  end

  # PATCH/PUT /plans/1
  def update
    authorize(@plan)
    @plan_markers =  current_user.all_plans.map {|plan| {lat: plan.latitude, long: plan.longitude, title: plan.title}}.flatten
    if @plan.update(plan_params)
      redirect_to @plan, notice: 'Plan was successfully updated.'
    else
      render :edit
    end
    @plan.labels = Label.update_labels(params[:plan][:labels])
  end

  # DELETE /plans/1
  def destroy
    authorize(@plan)
    @plan.destroy
    redirect_to plans_url, notice: 'Plan was successfully cancelled.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def plan_params
      params.require(:plan).permit(:title, :caption, :date, :address, :latitude, :longitude, :avatar)
    end
end
