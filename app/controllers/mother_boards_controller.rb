class MotherBoardsController < ApplicationController
  before_action :set_mother_board, only: %i[ update destroy ]

  # GET /mother_boards/1/edit
  def edit
  end

  # POST /mother_boards
  def create
    @mother_board = MotherBoard.new(mother_board_params)

    if @mother_board.save
      redirect_to @mother_board, notice: "Mother board was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mother_boards/1
  def update
    if @mother_board.update(mother_board_params)
      redirect_to @mother_board, notice: "Mother board was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /mother_boards/1
  def destroy
    @mother_board.destroy!
    redirect_to mother_boards_path, notice: "Mother board was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mother_board
      @mother_board = MotherBoard.find(params.expect(:id))
    end

    def mother_board_params
      attrs = params.permit![:mother_board]
      attrs[:config] = JSON.parse(attrs[:config])
      attrs
    end
end
