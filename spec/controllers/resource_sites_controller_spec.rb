require 'rails_helper'

describe ResourceSitesController, type: :controller do
  def assert_instance_variables_assigned(*required_instance_variables)
    do_request
    required_instance_variables.each do |required_var|
      expect(assigns(required_var)).to_not be_nil
    end
  end

  let(:success_flash) { flash[:success] }
  let(:alert_flash) { flash[:alert] }

  describe '#index' do
    subject(:do_request) { get :index }

    specify { assert_instance_variables_assigned(:resource_sites) }
  end

  describe '#show' do
    subject(:do_request) { get :show, id: resource_site.id }
    let!(:resource_site) { FactoryGirl.create(:resource_site) }

    specify { assert_instance_variables_assigned(:resource_site) }
  end

  describe '#new' do
    subject(:do_request) { get :new }

    specify { assert_instance_variables_assigned(:resource_site) }
  end

  describe '#create' do
    subject(:do_request) { post :create, resource_site_params }
    let(:resource_site_params) do
      { resource_site: { name: 'Resource Site 1', address: 'New York', description: 'Nondescript.' } }
    end

    specify { assert_instance_variables_assigned(:resource_site) }

    context 'when the new resource site is successfully created' do
      it 'redirects to the resource site show page with a success flash about creating a site' do
        do_request
        new_resource_site = ResourceSite.last
        expect(response).to redirect_to(resource_site_path(new_resource_site))
        expect(success_flash).to include('created')
      end
    end

    context 'when the new resource site fails to save' do
      let(:resource_site_params) do
        { resource_site: { name: '', address: 'New York', description: 'Nondescript.' } }
      end

      it 're-renders the new resource site page with an alert flash containing relevant errors' do
        do_request
        expect(response).to render_template(:new)
        expect(alert_flash).to include('Name can\'t be blank')
      end
    end
  end

  describe '#edit' do
    subject(:do_request) { get :edit, id: resource_site.id }
    let!(:resource_site) { FactoryGirl.create(:resource_site) }

    specify { assert_instance_variables_assigned(:resource_site) }
  end

  describe '#update' do
    subject(:do_request) do
      patch :update, { id: resource_site.id }.merge(resource_site_params)
    end
    let!(:resource_site) { FactoryGirl.create(:resource_site) }
    let(:resource_site_params) do
      { resource_site: { name: 'Resource Site 1', address: 'New York', description: 'Nondescript.' } }
    end

    specify { assert_instance_variables_assigned(:resource_site) }

    context 'when the new resource site is successfully updated' do
      it 'redirects to the resource site show page with a success flash about creating a site' do
        do_request
        expect(response).to redirect_to(resource_site_path(resource_site))
        expect(success_flash).to include('updated')
      end
    end

    context 'when the new resource site fails to update' do
      let(:resource_site_params) do
        { resource_site: { name: '', address: 'New York', description: 'Nondescript.' } }
      end

      it 're-renders the new resource site page with an alert flash containing relevant errors' do
        do_request
        expect(response).to render_template(:edit)
        expect(alert_flash).to include('Name can\'t be blank')
      end
    end
  end

  describe '#destroy' do
    subject(:do_request) { delete :destroy, id: resource_site.id }
    let!(:resource_site) { FactoryGirl.create(:resource_site) }

    it 'destroys the indicated resource site' do
      expect { do_request }.to change { ResourceSite.all.to_a }.from([resource_site]).to([])
    end

    it 'redirects to the resource site index page with a success flash about destroying the site' do
      do_request
      expect(response).to redirect_to(resource_sites_path)
      expect(success_flash).to include(resource_site.name)
      expect(success_flash).to include('deleted')
    end
  end
end
