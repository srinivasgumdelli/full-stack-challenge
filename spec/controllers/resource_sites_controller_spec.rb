require 'rails_helper'
require 'controller_helper'

describe ResourceSitesController, type: :controller do
  def assert_instance_variables_assigned(*required_instance_variables)
    do_request
    required_instance_variables.each do |required_var|
      expect(assigns(required_var)).to_not be_nil
    end
  end

  let(:success_flash) { flash[:success] }
  let(:alert_flash) { flash[:alert] }
  let(:user) { FactoryGirl.create(:user) }

  describe '#index' do
    subject(:do_request) { get :index }

    specify { assert_instance_variables_assigned(:resource_sites) }
  end

  describe '#show' do
    before do
      Eligibility.delete_all
    end
    subject(:do_request) { get :show, id: resource_site.id }
    let!(:resource_site) { FactoryGirl.create(:resource_site) }

    context 'not logged in' do
      it 'redirects to user signin page' do
        do_request
        expect(response).to redirect_to(new_user_session_path)
        expect(alert_flash).to include('You need to be signed in')
      end
    end

    context 'logged in' do
      before do
        sign_in user
      end
      it 'renders the show template' do
        do_request

        expect(response).to render_template(:show)
      end
    end
  end

  describe '#new' do
    subject(:do_request) { get :new }

    context 'not logged in' do
      it 'redirects to user sign_in path' do
        do_request

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'logged in' do
      before do
        sign_in user
      end
      it 'renders new page template' do
        do_request

        expect(response).to render_template(:new)
      end

      specify { assert_instance_variables_assigned(:resource_site) }
    end

  end

  describe '#create' do
    before do
      Eligibility.delete_all
    end
    subject(:do_request) { post :create, resource_site_params }
    let!(:eligibility) { FactoryGirl.create(:eligibility) }
    let(:resource_site_params) do
      { resource_site: { name: 'Resource Site 1', address: 'New York', description: 'Nondescript.',
                         eligibility_id: eligibility.id } }
    end

    context 'not logged in' do
      it 'redirects to user signin page' do
        do_request

        expect(response).to redirect_to(new_user_session_path)
        expect(alert_flash).to include('You need to be signed in')
      end
    end

    context 'logged in' do
      before do
        sign_in user
      end
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

      specify { assert_instance_variables_assigned(:resource_site) }
    end
  end

  describe '#edit' do
    subject(:do_request) { get :edit, id: resource_site.id }
    let!(:resource_site) { FactoryGirl.create(:resource_site) }

    context 'not logged in' do
      it 'should redirect to user signin page' do
        do_request

        expect(response).to redirect_to(new_user_session_path)
        expect(alert_flash).to include('You need to be signed in')
      end
    end

    context 'logged in' do
      before do
        sign_in user
      end
      it 'should render edit page' do
        do_request

        expect(response).to render_template(:edit)
      end

      specify { assert_instance_variables_assigned(:resource_site) }
    end

  end

  describe '#update' do
    subject(:do_request) do
      patch :update, { id: resource_site.id }.merge(resource_site_params)
    end
    let!(:resource_site) { FactoryGirl.create(:resource_site) }
    let(:resource_site_params) do
      { resource_site: { name: 'Resource Site 1', address: 'New York', description: 'Nondescript.' } }
    end

    context 'not logged in' do
      it 'redirects to user sign in page' do
        do_request

        expect(response).to redirect_to(new_user_session_path)
        expect(alert_flash).to include('You need to be signed in')
      end
    end

    context 'logged in' do
      before do
        sign_in user
      end

      specify { assert_instance_variables_assigned(:resource_site) }

      context 'when the new resource site is successfully updated' do
        it 'redirects to the resource site show page with a success flash about updating a site' do
          do_request
          expect(response).to redirect_to(resource_site_path(resource_site))
          expect(success_flash).to include('updated')
        end
      end

      context 'when the new resource site fails to update' do
        let(:resource_site_params) do
          { resource_site: { name: '', address: 'New York', description: 'Nondescript.' } }
        end

        it 're-renders the edit resource site page with an alert flash containing relevant errors' do
          do_request
          expect(response).to render_template(:edit)
          expect(alert_flash).to include('Name can\'t be blank')
        end
      end
    end
  end

  describe '#destroy' do
    subject(:do_request) { delete :destroy, id: resource_site.id }
    let!(:resource_site) { FactoryGirl.create(:resource_site) }

    context 'not logged in' do
      it 'redirects to user sign in page' do
        do_request

        expect(response).to redirect_to(new_user_session_path)
        expect(alert_flash).to include('You need to be signed in')
      end
    end

    context 'logged in' do
      before do
        sign_in user
      end

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

end
