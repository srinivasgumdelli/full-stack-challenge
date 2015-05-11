require 'rails_helper'
require 'controller_helper'

RSpec.describe EligibilitiesController, type: :controller do
  def assert_instance_variables_assigned(*required_instance_variables)
    do_request
    required_instance_variables.each do |required_var|
      expect(assigns(required_var)).to_not be_nil
    end
  end

  let(:success_flash) { flash[:success] }
  let(:alert_flash) { flash[:alert] }
  let(:user) { FactoryGirl.create(:user) }
  let(:eligibility) { Eligibility.create({eligibility: 'Test', description: 'TestDescription'}) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe '#index' do
    subject(:do_request) { get :index }

    specify { assert_instance_variables_assigned(:eligibilities) }
  end

  describe '#show' do
    subject(:do_request) { get :show, id: eligibility.id }

    context 'when not logged in' do
      it 'redirects to root path' do
        do_request

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged in as non-admin' do
      before do
        sign_in user
      end
      it 'redirects to root path' do
        do_request

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged in as admin' do
      before do
        sign_in admin
      end
      it 'renders show template' do
        do_request

        expect(response).to render_template(:show)

        assert_instance_variables_assigned(:eligibility)
      end
    end
  end

  describe '#new' do
    subject(:do_request) { get :new }

    context 'not logged in' do
      it 'redirects to root path' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as non-admin' do
      before do
        sign_in user
      end
      it 'redirects to root path with appropriate flash message' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as admin' do
      before do
        sign_in admin
      end
      it 'renders the new template' do
        do_request

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create' do
    let(:eligibility_params) do
      { eligibility: { eligibility: 'eligibility', description: 'test description' } }
    end
    subject(:do_request) {
      Eligibility.delete_all
      post :create, eligibility_params
    }

    context 'not logged in' do
      it 'redirects to root path' do
        do_request

        expect(response).to redirect_to(root_path)
      end
    end

    context 'logged in as non-admin' do
      before do
        sign_in user
      end
      it 'redirects to root path with appropriate flash message' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as admin' do
      before do
        sign_in admin
      end
      context 'when the new eligibility is sucessfully created' do
        it 'redirects to the new eligibility show page with a success flash' do
          do_request
          new_eligibility = Eligibility.last
          expect(response).to redirect_to(eligibility_path(new_eligibility))
          expect(success_flash).to include('created')
        end
      end

      context 'when the new eligibility fails to save' do
        let(:eligibility_params) do
          { eligibility: { eligibility: '', description: 'test' } }
        end
        it 're-renders the new eligibility page with an alert flash containing relevant errors' do
          do_request
          expect(response).to render_template(:new)
          expect(alert_flash).to include('Eligibility can\'t be blank')
        end
      end

      specify { assert_instance_variables_assigned(:eligibility) }
    end
  end

  describe '#edit' do
    before do
      Eligibility.delete_all
    end
    subject(:do_request) { get :edit, id: eligibility.id }
    let!(:eligibility) { FactoryGirl.create(:eligibility) }

    context 'not logged in' do
      it 'redirects to root path' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as a non-admin' do
      before do
        sign_in user
      end
      it 'redirects to root path with relevant error message' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as admin' do
      before do
        sign_in admin
      end
      it 'renders the edit template' do
        do_request

        expect(response).to render_template(:edit)
      end

      specify { assert_instance_variables_assigned(:eligibility) }
    end
  end

  describe '#update' do
    subject(:do_request) do
      patch :update, { id: eligibility.id }.merge(eligibility_params)
    end
    let!(:eligibility) { FactoryGirl.create(:eligibility) }
    let(:eligibility_params) do
      { eligibility: { eligibility: 'eligibility1', description: 'test description' } }
    end

    context 'not logged in' do
      it 'redirects to root path with appropriate alert message' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as non-admin' do
      before do
        sign_in user
      end
      it 'redirects to root path with appropriate alert message' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as admin' do
      before do
        sign_in admin
      end
      context 'when the new eligibility is successfully created' do
        it 'redirects to the new eligibility show page with an updated success flash' do
          do_request
          expect(response).to redirect_to(eligibility_path(eligibility))
          expect(success_flash).to include('updated')
        end
      end

      context 'when the new eligibility fails to save' do
        let(:eligibility_params) do
          { eligibility: { eligibility: '', description: 'test' } }
        end
        it 're-renders the update eligibility template with an alert flash containing relevant errors' do
          do_request
          expect(response).to render_template(:edit)
          expect(alert_flash).to include('Eligibility can\'t be blank')
        end
      end
    end
  end

  describe '#destroy' do
    subject(:do_request) { delete :destroy, id: eligibility.id }
    let!(:eligibility) { FactoryGirl.create(:eligibility) }

    context 'not logged in' do
      it 'redirects to root path with appropriate alert message' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as non-admin' do
      before do
        sign_in user
      end
      it 'redirects to root path with appropriate alert message' do
        do_request

        expect(response).to redirect_to(root_path)
        expect(alert_flash).to include('You require admin privileges for editing eligibilities')
      end
    end

    context 'logged in as admin' do
      before do
        sign_in admin
      end
      context 'fails to destroy eligibility as per foreign key contraint' do
        it 'redirects to eligibilities path with relevant flash message' do
          do_request

          expect(response).to redirect_to(eligibilities_path)
          expect(alert_flash).to include('The eligibility could not be deleted. Are there any resource sites with this eligibility?')
        end
      end
    end
  end
end
