require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  # TODO: Do I need to merge in some attributes?
  let(:valid_attributes) {
    attributes_for(:role).merge(company_id: company.id)
  }

  let(:invalid_attributes) {
    {
      name: nil,
      key: nil
    }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all roles as @roles" do
      role = Role.create! valid_attributes
      get :index, params: {company_id: company.to_param}, session: valid_session
      expect(assigns(:roles)).to match_array([role])
    end
  end

  describe "GET show" do
    it "assigns the requested role as @role" do
      role = Role.create! valid_attributes
      get :show, params: {company_id: company.to_param, id: role.to_param}, session: valid_session
      expect(assigns(:role)).to eq(role)
    end
  end

  describe "GET new" do
    it "assigns a new role as @role" do
      get :new, params: {company_id: company.to_param}, session: valid_session
      expect(assigns(:role)).to be_a_new(Role)
    end
  end

  describe "GET edit" do
    it "assigns the requested role as @role" do
      role = Role.create! valid_attributes
      get :edit, params: {company_id: company.to_param, id: role.to_param}, session: valid_session
      expect(assigns(:role)).to eq(role)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Role" do
        expect {
          post :create, params: {company_id: company.to_param, role: valid_attributes}, session: valid_session
        }.to change(Role, :count).by(1)
      end

      it "assigns a newly created role as @role" do
        post :create, params: {company_id: company.to_param, role: valid_attributes}, session: valid_session
        expect(assigns(:role)).to be_a(Role)
        expect(assigns(:role)).to be_persisted
      end

      it "redirects to the created role" do
        post :create, params: {company_id: company.to_param, role: valid_attributes}, session: valid_session
        expect(response).to redirect_to([company, Role.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved role as @role" do
        post :create, params: {company_id: company.to_param, role: invalid_attributes}, session: valid_session
        expect(assigns(:role)).to be_a_new(Role)
      end

      it "re-renders the 'new' template" do
        post :create, params: {company_id: company.to_param, role: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
          name: 'My Name',
        }
      }

      it "updates the requested role" do
        role = Role.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: role.to_param, role: new_attributes}, session: valid_session
        role.reload
        expect(role.name).to eql('My Name')
      end

      it "assigns the requested role as @role" do
        role = Role.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: role.to_param, role: valid_attributes}, session: valid_session
        expect(assigns(:role)).to eq(role)
      end

      it "redirects to the role" do
        role = Role.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: role.to_param, role: valid_attributes}, session: valid_session
        expect(response).to redirect_to([role.company, role])
      end
    end

    describe "with invalid params" do
      it "assigns the role as @role" do
        role = Role.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: role.to_param, role: invalid_attributes}, session: valid_session
        expect(assigns(:role)).to eq(role)
      end

      it "re-renders the 'edit' template" do
        role = Role.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: role.to_param, role: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested role" do
      role = Role.create! valid_attributes
      expect {
        delete :destroy, params: {company_id: company.to_param, id: role.to_param}, session: valid_session
      }.to change(Role, :count).by(-1)
    end

    it "redirects to the roles list" do
      role = Role.create! valid_attributes
      delete :destroy, params: {company_id: company.to_param, id: role.to_param}, session: valid_session
      expect(response).to redirect_to(company_roles_url(company))
    end
  end

end
