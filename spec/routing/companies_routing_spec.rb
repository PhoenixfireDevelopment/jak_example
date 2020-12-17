require 'rails_helper'

RSpec.describe CompaniesController, type: :routing do
  describe 'routing' do
    let(:url) { 'http://dummy.test' }
    let(:namespace) { 'companies' }
    let(:path) { 'companies' }

    it 'routes to #index' do
      expect(get: "#{url}/#{path}").to route_to("#{namespace}#index")
    end

    it 'routes to #new' do
      expect(get: "#{url}/#{path}/new").to route_to("#{namespace}#new")
    end

    it 'routes to #show' do
      expect(get: "#{url}/#{path}/1").to route_to("#{namespace}#show", id: '1')
    end

    it 'routes to #edit' do
      expect(get: "#{url}/#{path}/1/edit").to route_to("#{namespace}#edit", id: '1')
    end

    it 'routes to #create' do
      expect(post: "#{url}/#{path}").to route_to("#{namespace}#create")
    end

    it 'routes to #update via PUT' do
      expect(put: "#{url}/#{path}/1").to route_to("#{namespace}#update", id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{url}/#{path}/1").to route_to("#{namespace}#update", id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{url}/#{path}/1").to route_to("#{namespace}#destroy", id: '1')
    end
  end
end
