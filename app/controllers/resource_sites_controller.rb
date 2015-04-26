class ResourceSitesController < ApplicationController
  def index
    @resource_sites = ResourceSite.all
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
    params.require(:resource_site).permit(:name, :description, :address)
  end
end
