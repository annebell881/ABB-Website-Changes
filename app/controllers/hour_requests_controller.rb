class HourRequestsController < ApplicationController
  def index
    @requests = HourRequest.all
  end

  def show
    @request = HourRequest.find(params[:id])

    @user = User.find(@request.user_id)
  end

  def new
    @user = current_user
    @request = HourRequest.new
  end

  def create
    @request = HourRequest.new(hour_request_params)

    respond_to do |format|
      if @request.save
        
        format.html { redirect_to controller: :membership, action: :index, notice: "Hour Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @request = HourRequest.find(params[:id])
  end

  def update
    @request = HourRequest.find(params[:id])

    respond_to do |format|
      if @request.update(hour_request_params)
        format.html { redirect_to controller: :membership, action: :index, notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request = HourRequest.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to controller: :membership, action: :index, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def approve
    request = HourRequest.find(params['id'])
    category = request.category
    approved_points = request.points

    user = User.find(request.user_id)
    
    if category == "Networking"
      user.service_points += approved_points
      user.save
    elsif category == "Brotherhood"
      user.brother_points += approved_points
      user.save
    elsif category == "Professionalism"
      user.social_points += approved_points
      user.save
    elsif category == "Meetings"
      user.study_hours += approved_points
      user.save
    end
    
    request.destroy
    respond_to do |format|
      format.html { redirect_to action: :index, notice: "Request was successfully approved." }
      format.json { head :no_content }
    end
  end

  def deny 
    request = HourRequest.find(params['id'])
    request.destroy

    respond_to do |format|
      format.html { redirect_to action: :index, notice: "Request was denied." }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def hour_request_params
      params.require(:hour_request).permit(:user_id, :points, :category, :description)
    end
end
