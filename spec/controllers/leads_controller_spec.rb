require 'rails_helper'

RSpec.describe LeadsController, type: :controller do
  let(:company) { create(:company) }
  let(:assignable) { create(:user, company: company) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(assignable)
  end

  let(:valid_attributes) {
    attributes_for(:lead).merge(company_id: company.id, assignable_id: assignable.id)
  }

  let(:invalid_attributes) {
    {
      name: nil,
    }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all leads as @leads" do
      lead = Lead.create! valid_attributes
      get :index, params: {company_id: company.to_param}, session: valid_session
      expect(assigns(:leads)).to match_array([lead])
    end
  end

  describe "GET show" do
    it "assigns the requested lead as @lead" do
      lead = Lead.create! valid_attributes
      get :show, params: {company_id: company.to_param, id: lead.to_param}, session: valid_session
      expect(assigns(:lead)).to eq(lead)
    end
  end

  describe "GET new" do
    it "assigns a new lead as @lead" do
      get :new, params: {company_id: company.to_param}, session: valid_session
      expect(assigns(:lead)).to be_a_new(Lead)
    end
  end

  describe "GET edit" do
    it "assigns the requested lead as @lead" do
      lead = Lead.create! valid_attributes
      get :edit, params: {company_id: company.to_param, id: lead.to_param}, session: valid_session
      expect(assigns(:lead)).to eq(lead)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Lead" do
        expect {
          post :create, params: {company_id: company.to_param, lead: valid_attributes}, session: valid_session
        }.to change(Lead, :count).by(1)
      end

      it "assigns a newly created lead as @lead" do
        post :create, params: {company_id: company.to_param, lead: valid_attributes}, session: valid_session
        expect(assigns(:lead)).to be_a(Lead)
        expect(assigns(:lead)).to be_persisted
      end

      it "redirects to the created lead" do
        post :create, params: {company_id: company.to_param, lead: valid_attributes}, session: valid_session
        expect(response).to redirect_to([company, Lead.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved lead as @lead" do
        post :create, params: {company_id: company.to_param, lead: invalid_attributes}, session: valid_session
        expect(assigns(:lead)).to be_a_new(Lead)
      end

      it "re-renders the 'new' template" do
        post :create, params: {company_id: company.to_param, lead: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
          name: 'My Name'
        }
      }

      it "updates the requested lead" do
        lead = Lead.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: lead.to_param, lead: new_attributes}, session: valid_session
        lead.reload
        expect(lead.name).to eql('My Name')
      end

      it "assigns the requested lead as @lead" do
        lead = Lead.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: lead.to_param, lead: valid_attributes}, session: valid_session
        expect(assigns(:lead)).to eq(lead)
      end

      it "redirects to the lead" do
        lead = Lead.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: lead.to_param, lead: valid_attributes}, session: valid_session
        expect(response).to redirect_to([company, lead])
      end
    end

    describe "with invalid params" do
      it "assigns the lead as @lead" do
        lead = Lead.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: lead.to_param, lead: invalid_attributes}, session: valid_session
        expect(assigns(:lead)).to eq(lead)
      end

      it "re-renders the 'edit' template" do
        lead = Lead.create! valid_attributes
        put :update, params: {company_id: company.to_param, id: lead.to_param, lead: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested lead" do
      lead = Lead.create! valid_attributes
      expect {
        delete :destroy, params: {company_id: company.to_param, id: lead.to_param}, session: valid_session
      }.to change(Lead, :count).by(-1)
    end

    it "redirects to the leads list" do
      lead = Lead.create! valid_attributes
      delete :destroy, params: {company_id: company.to_param, id: lead.to_param}, session: valid_session
      expect(response).to redirect_to(company_leads_url)
    end
  end
end
