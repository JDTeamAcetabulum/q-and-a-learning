class UserIDsController < ApplicationController
  before_action :set_user_id, only: [:show, :edit, :update, :destroy]

  # GET /user_ids
  # GET /user_ids.json
  def index
    @user_ids = UserId.all
  end

  # GET /user_ids/1
  # GET /user_ids/1.json
  def show
  end

  # GET /user_ids/new
  def new
    @user_id = UserId.new
  end

  # GET /user_ids/1/edit
  def edit
  end

  # POST /user_ids
  # POST /user_ids.json
  def create
    @user_id = UserId.new(user_id_params)

    respond_to do |format|
      if @user_id.save
        format.html { redirect_to @user_id, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user_id }
      else
        format.html { render :new }
        format.json { render json: @user_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_ids/1
  # PATCH/PUT /user_ids/1.json
  def update
    respond_to do |format|
      if @user_id.update(user_id_params)
        format.html { redirect_to @user_id, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_id }
      else
        format.html { render :edit }
        format.json { render json: @user_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_ids/1
  # DELETE /user_ids/1.json
  def destroy
    @user_id.destroy
    respond_to do |format|
      format.html { redirect_to user_ids_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_id
      @user_id = UserId.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_id_params
      params.require(:user_id).permit(:username, :Last, :id)
    end
end
