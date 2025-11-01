class HardDrivesController < ApplicationController
  before_action :set_hard_drive, only: %i[update destroy ]

  # POST /hard_drives
  def create
    @hard_drive = HardDrive.new(hard_drive_params)

    if @hard_drive.save
      redirect_to @hard_drive, notice: "Hard drive was successfully created."
    else
      p @hard_drive.errors
      render json: @hard_drive.errors
    end
  end

  # PATCH/PUT /hard_drives/1
  def update
    if @hard_drive.update(hard_drive_params)
      redirect_to @hard_drive, notice: "Hard drive was successfully updated.", status: :see_other
    else
      p @hard_drive.errors
      render json: @hard_drive.errors
    end
  end

  # DELETE /hard_drives/1
  def destroy
    @hard_drive.destroy!
    redirect_to hard_drives_path, notice: "Hard drive was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hard_drive
      @hard_drive = HardDrive.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def hard_drive_params
      params.permit![:hard_drive]
    end
end
