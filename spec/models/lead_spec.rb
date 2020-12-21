require 'rails_helper'

RSpec.describe Lead, type: :model do
  describe "concerning validations" do

    let(:company_1) { create(:company, name: 'Phoenixfire') }
    let(:company_2) { create(:company, name: 'Blackwing') }

    it "has a valid factory" do
      expect(build(:lead)).to be_valid
    end

    it 'requires the company' do
      expect(build(:lead, company: nil)).to_not be_valid
    end

    it 'requires the company_id' do
      expect(build(:lead, company_id: nil)).to_not be_valid
    end

    it 'requires the name' do
      expect(build(:lead, name: nil)).to_not be_valid
    end

    it 'requires a unique name' do
      expect(create(:lead, name: 'lead', company: company_1)).to be_valid
      expect(build(:lead, name: 'lead', company: company_1)).to_not be_valid
    end

    it 'requires a unique name regardless of case' do
      expect(create(:lead, name: 'lead', company: company_1)).to be_valid
      expect(build(:lead, name: 'LEAD', company: company_1)).to_not be_valid
    end

    it 'requires a unique name regardless of case scoped to company' do
      expect(create(:lead, name: 'lead', company: company_1)).to be_valid
      expect(build(:lead, name: 'LEAD', company: company_1)).to_not be_valid
      expect(build(:lead, name: 'LEAD', company: company_2)).to be_valid
    end
  end
end
