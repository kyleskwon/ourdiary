class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  def index
    @items = current_user.all_items
    authorize :item, :index?
    if params[:search]
      @items = Item.for_user(current_user).search(params[:search]).order("created_at DESC")
    else
      @items = Item.for_user(current_user).order("created_at DESC")
    end
    @item_markers =  current_user.all_items.map {|item| {lat: item.latitude, long: item.longitude, title: item.title}}.flatten
  end

  # GET /items/1
  def show
    @item = Item.find(params[:id])
    authorize(@item)
    items = current_user.all_items.map(&:id)
    current = items.index(@item.id)
    @previous = Item.find(items[current - 1]) unless current == 0
    @next = Item.find(items[current + 1]) unless current == items.length - 1
    @item_markers =  current_user.all_items.map {|item| {lat: item.latitude, long: item.longitude, title: item.title}}.flatten
  end

  # GET /items/new
  def new
    @item = Item.new
    authorize(@item)
    @item_markers =  current_user.all_items.map {|item| {lat: item.latitude, long: item.longitude, title: item.title}}.flatten
  end

  # GET /items/1/edit
  def edit
    authorize(@item)
    @item_markers =  current_user.all_items.map {|item| {lat: item.latitude, long: item.longitude, title: item.title}}.flatten
  end

  # POST /items
  def create
    @item = current_user.items.create(item_params)
    authorize(@item)
    @item_markers =  current_user.all_items.map {|item| {lat: item.latitude, long: item.longitude, title: item.title}}.flatten
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
    @item.labels = Label.update_labels(params[:item][:labels])
  end

  # PATCH/PUT /items/1
  def update
    authorize(@item)
    @item_markers =  current_user.all_items.map {|item| {lat: item.latitude, long: item.longitude, title: item.title}}.flatten
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
    @item.labels = Label.update_labels(params[:item][:labels])
  end

  # DELETE /items/1
  def destroy
    authorize(@item)
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:title, :caption, :address, :latitude, :longitude, :avatar)
    end
end
