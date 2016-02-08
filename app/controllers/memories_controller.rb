class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :search, :update, :destroy]

  # GET /memories
  def index
    @memories = current_user.all_memories
    if params[:search]
      @memories = Memory.search(params[:search]).order("created_at DESC")
    else
      @memories = Memory.order("created_at DESC")
    end
    @memory_markers =  current_user.all_memories.map {|memory| {lat: memory.latitude, long: memory.longitude, title: memory.title}}.flatten
  end

  # GET /memories/1
  def show
    @memory = Memory.find(params[:id])
    memories = current_user.all_memories.map(&:id)
    current = memories.index(@memory.id)
    @previous = Memory.find(memories[current - 1]) unless current == 0
    @next = Memory.find(memories[current + 1]) unless current == memories.length - 1
    @memory_markers =  current_user.all_memories.map {|memory| {lat: memory.latitude, long: memory.longitude, title: memory.title}}.flatten
  end

  # GET /memories/new
  def new
    @memory = Memory.new
    @memory_markers =  current_user.all_memories.map {|memory| {lat: memory.latitude, long: memory.longitude, title: memory.title}}.flatten
  end

  # GET /memories/1/edit
  def edit
    @memory_markers =  current_user.all_memories.map {|memory| {lat: memory.latitude, long: memory.longitude, title: memory.title}}.flatten
  end

  # POST /memories
  def create
    @memory = current_user.memories.create(memory_params)

    if @memory.save
      redirect_to @memory, notice: 'Item was successfully created.'
    else
      render :new
    end
    @memory.labels = Label.update_labels(params[:memory][:labels])
  end

  # PATCH/PUT /memories/1
  def update
    if @memory.update(memory_params)
      redirect_to @memory, notice: 'Memory was successfully updated.'
    else
      render :edit
    end
    @memory.labels = Label.update_labels(params[:memory][:labels])
  end

  # DELETE /memories/1
  def destroy
    @memory.destroy
    redirect_to memories_url, notice: 'Memory was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def memory_params
      params.require(:memory).permit(:title, :caption, :date, :label, :address, :latitude, :longitude, :avatar)
    end
end
