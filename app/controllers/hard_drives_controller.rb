class HardDrivesController < ApplicationController
  before_action :set_hard_drife, only: %i[ show edit update destroy ]

  # GET /hard_drives/1/edit
  def edit
  end

  # POST /hard_drives
  def create
    @hard_drife = HardDrive.new(hard_drife_params)

    if @hard_drife.save
      redirect_to @hard_drife, notice: "Hard drive was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hard_drives/1
  def update
    if @hard_drife.update(hard_drife_params)
      redirect_to @hard_drife, notice: "Hard drive was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /hard_drives/1
  def destroy
    @hard_drife.destroy!
    redirect_to hard_drives_path, notice: "Hard drive was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hard_drife
      @hard_drife = HardDrive.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def hard_drife_params
      params.fetch(:hard_drife, {})
    end
end
