class EligibilitiesController < ApplicationController
  before_action :require_admin, :except => [:index]

  def index
    @eligibilities = Eligibility.all
  end

  def show
    @eligibility = Eligibility.find(params[:id])
  end

  def new
    @eligibility = Eligibility.new
  end

  def create
    @eligibility = Eligibility.new(eligibility_params)

    if @eligibility.save
      redirect_to eligibility_path(@eligibility), flash: { success: 'Eligibility created.' }
    else
      flash.now[:alert] = @eligibility.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @eligibility = Eligibility.find(params[:id])
  end

  def update
    @eligibility = Eligibility.find(params[:id])

    if @eligibility.update(eligibility_params)
      redirect_to eligibility_path(@eligibility), flash: { success: 'Eligibility updated.' }
    else
      flash.now[:alert] = @eligibility.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    eligibility = Eligibility.find(params[:id])

    if eligibility.destroy
      redirect_to eligibilities_path, flash: { success: "The eligibility '#{eligibility.eligibility}' was deleted." }
    else
      redirect_to eligibilities_path,
                  flash: {alert: 'The eligibility could not be deleted. Are there any resource sites with this eligibility?'}
    end
  end

  private
  def eligibility_params
    params.require(:eligibility).permit(:eligibility, :description)
  end

  def require_admin
    unless user_signed_in? && current_user.admin?
      flash[:alert] = 'You require admin privileges for editing eligibilities'
      redirect_to root_path
    end
  end
end
