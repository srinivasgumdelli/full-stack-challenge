class ResourceSitesController < ApplicationController
  before_filter :require_logged_in, :except => [:index]

  def index
    @eligibility_ids = params[:eligibilities]
    if @eligibility_ids.nil?
      @resource_sites = ResourceSite.all
    else
      @resource_sites = ResourceSite.where(eligibility_id: @eligibility_ids)
    end
    @eligibilities = Eligibility.all
  end

  def show
    @resource_site = ResourceSite.find(params[:id])
  end

  def new
    @resource_site = ResourceSite.new
  end

  def create
    @resource_site = ResourceSite.new(resource_site_params)

    if @resource_site.save
      redirect_to resource_site_path(@resource_site), flash: { success: 'Resource site created.' }
    else
      flash.now[:alert] = @resource_site.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @resource_site = ResourceSite.find(params[:id])
  end

  def update
    @resource_site = ResourceSite.find(params[:id])

    if @resource_site.update(resource_site_params)
      redirect_to resource_site_path(@resource_site), flash: { success: 'Resource site updated.' }
    else
      flash.now[:alert] = @resource_site.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    resource_site = ResourceSite.find(params[:id])

    resource_site.destroy
    redirect_to resource_sites_path, flash: {
                                       success: "The resource site '#{resource_site.name}' was deleted."
                                   }
  end

  private

  def resource_site_params
    params.require(:resource_site).permit(:name, :description, :address, :eligibility_id )
  end

  def require_logged_in
    unless user_signed_in?
      flash[:alert] = 'You need to be signed in'
      redirect_to new_user_session_path
    end
  end
end
