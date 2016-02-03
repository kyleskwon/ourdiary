class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]

  # GET /memories
  def index
    @memories = current_user.all_memories
  end

  # GET /memories/1
  def show
    @memory = Memory.find(params[:id])
    @previous = Memory.where("id < ?", params[:id]).order(:id).first
    @next = Memory.where("id > ?", params[:id]).order(:id).first
  end

  # GET /memories/new
  def new
    @memory = Memory.new
  end

  # GET /memories/1/edit
  def edit
  end

  # POST /memories
  def create
    @memory = current_user.memories.create(memory_params)

    if @memory.save
      redirect_to @memory, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /memories/1
  def update
    if @memory.update(memory_params)
      redirect_to @memory, notice: 'Memory was successfully updated.'
    else
      render :edit
    end
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
