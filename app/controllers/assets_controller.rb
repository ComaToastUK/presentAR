class AssetsController < ApplicationController
  before_action :set_asset, only: %i[show edit update destroy]

  # GET /assets
  # GET /assets.json
  def index
    @assets = Asset.all
  end

  # GET /assets/1
  # GET /assets/1.json
  def show; end

  # GET /assets/new
  def new
    @asset = current_user.assets.build
  end

  # GET /assets/1/edit
  # def edit
  # end

  # POST /assets
  # POST /assets.json
  def create
    @asset = current_user.assets.build(asset_params)
    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render :show, status: :created, location: @asset }
      else
        format.html { render :new }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # COMMENTED AS NOT IN USE
  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  # def update
  #   respond_to do |format|
  #     if @asset.update(asset_params)
  #       format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @asset }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @asset.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url, notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_asset
    @asset = Asset.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def asset_params
    params.require(:asset).permit(:uploaded_file, :model_image, :image_target, :name)
  end
end
