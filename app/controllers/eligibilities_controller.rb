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
      redirect_to eligibility_path(@eligibility), flash: { success: 'Resource site created.' }
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
      redirect_to eligibility_path(@eligibility), flash: { success: 'Resource site updated.' }
    else
      flash.now[:alert] = @eligibility.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    eligibility = Eligibility.find(params[:id])

    eligibility.destroy
    redirect_to eligibilities_path, flash: { success: "The eligibility '#{eligibility.eligibility}' was deleted." }
  end

  private
  def eligibility_params
    params.require(:eligibility).permit(:eligibility, :description)
  end

  def require_admin
    unless current_user.admin?
      flash[:alert] = 'You require admin privileges for editing eligibilities'
      redirect_to root_path
    end
  end
end
