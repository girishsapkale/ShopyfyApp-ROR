class MetalsController < ApplicationController
  before_action :set_metal, only: [:show, :edit, :update, :destroy]

  # GET /metals
  # GET /metals.json
  def index
    @metals = Metal.includes(:product)
  end

  # GET /metals/1
  # GET /metals/1.json
  def show
  end

  # GET /metals/new
  def new
    @metal = Metal.new
  end

  # GET /metals/1/edit
  def edit
    respond_to do |format|      
      format.js
    end
  end

  # POST /metals
  # POST /metals.json
  def create
    @metal = Metal.new(metal_params)

    respond_to do |format|
      if @metal.save
        format.html { redirect_to @metal, notice: 'Metal was successfully created.' }
        format.json { render :show, status: :created, location: @metal }
      else
        format.html { render :new }
        format.json { render json: @metal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metals/1
  # PATCH/PUT /metals/1.json
  def update
    respond_to do |format|
      if @metal.update(metal_params)
        format.html { redirect_to metals_url, notice: "'#{@metal.product.title}' product with metal '#{@metal.name}' was successfully updated." }
        format.json { render :show, status: :ok, location: @metal }
      else
        format.html { redirect_to metals_url, alert: "'#{@metal.product.title}' product with metal '#{@metal.name}' was failed to update." }
        format.json { render json: @metal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metals/1
  # DELETE /metals/1.json
  def destroy
    @metal.destroy
    respond_to do |format|
      format.html { redirect_to metals_url, notice: 'Metal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metal
      @metal = Metal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metal_params
      params.require(:metal).permit(:name, :price, :product_id)
    end
end
