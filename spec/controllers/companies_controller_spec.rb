require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  # TODO: Do I need to merge in some attributes?
  let(:valid_attributes) do
    attributes_for(:company)
  end

  let(:invalid_attributes) do
    {
      name: nil
    }
  end

  let(:valid_session) { {} }

  describe 'GET index' do
    it 'assigns all companies as @companies' do
      get :index, params: {}, session: valid_session
      expect(assigns(:companies)).to match_array([company])
    end
  end

  describe 'GET show' do
    it 'assigns the requested company as @company' do
      company = Company.create! valid_attributes
      get :show, params: { id: company.to_param }, session: valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'GET new' do
    it 'assigns a new company as @company' do
      get :new, params: {}, session: valid_session
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested company as @company' do
      company = Company.create! valid_attributes
      get :edit, params: { id: company.to_param }, session: valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Company' do
        expect do
          post :create, params: { company: valid_attributes }, session: valid_session
        end.to change(Company, :count).by(1)
      end

      it 'assigns a newly created company as @company' do
        post :create, params: { company: valid_attributes }, session: valid_session
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end

      it 'redirects to the created company' do
        post :create, params: { company: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Company.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved company as @company' do
        post :create, params: { company: invalid_attributes }, session: valid_session
        expect(assigns(:company)).to be_a_new(Company)
      end

      it "re-renders the 'new' template" do
        post :create, params: { company: invalid_attributes }, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        {
          name: 'My Name'
        }
      end

      it 'updates the requested company' do
        company = Company.create! valid_attributes
        put :update, params: { id: company.to_param, company: new_attributes }, session: valid_session
        company.reload
        expect(company.name).to eql('My Name')
      end

      it 'assigns the requested company as @company' do
        company = Company.create! valid_attributes
        put :update, params: { id: company.to_param, company: valid_attributes }, session: valid_session
        expect(assigns(:company)).to eq(company)
      end

      it 'redirects to the company' do
        company = Company.create! valid_attributes
        put :update, params: { id: company.to_param, company: valid_attributes }, session: valid_session
        expect(response).to redirect_to(company)
      end
    end

    describe 'with invalid params' do
      it 'assigns the company as @company' do
        company = Company.create! valid_attributes
        put :update, params: { id: company.to_param, company: invalid_attributes }, session: valid_session
        expect(assigns(:company)).to eq(company)
      end

      it "re-renders the 'edit' template" do
        company = Company.create! valid_attributes
        put :update, params: { id: company.to_param, company: invalid_attributes }, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested company' do
      company = Company.create! valid_attributes
      expect do
        delete :destroy, params: { id: company.to_param }, session: valid_session
      end.to change(Company, :count).by(-1)
    end

    it 'redirects to the companies list' do
      company = Company.create! valid_attributes
      delete :destroy, params: { id: company.to_param }, session: valid_session
      expect(response).to redirect_to(companies_url)
    end
  end
end
