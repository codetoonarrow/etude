class AvailabilityRangesController < ApplicationController
  def new
    @user = current_user
    @teacher = Teacher.find_by(user_id: @user.id)
    @availability_range = AvailabilityRange.new
  end

  def create
    @user = current_user
    @teacher = Teacher.find_by(user_id: @user.id)
    @availability_range = AvailabilityRange.new(
      weekday: availability_range_params[:weekday],
      start_time: availability_range_params[:start_time],
      end_time: availability_range_params[:end_time],
      teacher_id: @teacher.id
    )

    if @availability_range.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @current_user = current_user
    @teacher = Teacher.find_by(user_id: @current_user.id)
    @availability_ranges = AvailabilityRange.all
  end

  def edit
    @availability_range = AvailabilityRange.find(params[:id])
  end

  def update
    @availability_range = AvailabilityRange.find(params[:id])
    if @availability_range.update_attributes(availability_range_params)
      redirect_to user_url(current_user.id) 
    else
      render 'edit'
    end
  end

  def destroy
    @availability_range = AvailabilityRange.find(params[:id])
    @availability_range.delete
    redirect_to user_url(current_user.id)
  end

  private
  def availability_range_params
    params.require(:availability_range).permit(:weekday, :start_time, :end_time)
  end
end
