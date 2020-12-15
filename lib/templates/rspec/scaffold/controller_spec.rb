require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, type: :controller do
  let(:user) { create(:user) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  # TODO: Do I need to merge in some attributes?
  let(:valid_attributes) {
    attributes_for(:<%= file_name %>)
  }

  let(:invalid_attributes) {
    {
      name: nil,
    }
  }

  let(:valid_session) { {} }

<% unless options[:singleton] -%>
  describe "GET index" do
    it "assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:<%= table_name %>)).to match_array([<%= file_name %>])
    end
  end
<% end -%>

  describe "GET show" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      get :show, params: {id: <%= file_name %>.to_param}, session: valid_session
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe "GET new" do
    it "assigns a new <%= ns_file_name %> as @<%= ns_file_name %>" do
      get :new, params: {}, session: valid_session
      expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>)
    end
  end

  describe "GET edit" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      get :edit, params: {id: <%= file_name %>.to_param}, session: valid_session
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new <%= class_name %>" do
        expect {
          post :create, params: {:<%= ns_file_name %> => valid_attributes}, session: valid_session
        }.to change(<%= class_name %>, :count).by(1)
      end

      it "assigns a newly created <%= ns_file_name %> as @<%= ns_file_name %>" do
        post :create, params: {:<%= ns_file_name %> => valid_attributes}, session: valid_session
        expect(assigns(:<%= ns_file_name %>)).to be_a(<%= class_name %>)
        expect(assigns(:<%= ns_file_name %>)).to be_persisted
      end

      it "redirects to the created <%= ns_file_name %>" do
        post :create, params: {:<%= ns_file_name %> => valid_attributes}, session: valid_session
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved <%= ns_file_name %> as @<%= ns_file_name %>" do
        post :create, params: {:<%= ns_file_name %> => invalid_attributes}, session: valid_session
        expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:<%= ns_file_name %> => invalid_attributes}, session: valid_session
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

      it "updates the requested <%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update, params: {id: <%= file_name %>.to_param, :<%= ns_file_name %> => new_attributes}, session: valid_session
        <%= file_name %>.reload
        skip("Add assertions for updated state")
        expect(<%= file_name %>.name).to eql("My Name")
      end

      it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update, params: {id: <%= file_name %>.to_param, :<%= ns_file_name %> => valid_attributes}, session: valid_session
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it "redirects to the <%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update, params: {id: <%= file_name %>.to_param, :<%= ns_file_name %> => valid_attributes}, session: valid_session
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    describe "with invalid params" do
      it "assigns the <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update, params: {id: <%= file_name %>.to_param, :<%= ns_file_name %> => invalid_attributes}, session: valid_session
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it "re-renders the 'edit' template" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update, params: {id: <%= file_name %>.to_param, :<%= ns_file_name %> => invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested <%= ns_file_name %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      expect {
        delete :destroy, params: {id: <%= file_name %>.to_param}, session: valid_session
      }.to change(<%= class_name %>, :count).by(-1)
    end

    it "redirects to the <%= table_name %> list" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      delete :destroy, params: {id: <%= file_name %>.to_param}, session: valid_session
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end

end
<% end -%>
