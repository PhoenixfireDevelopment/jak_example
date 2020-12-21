require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'concerning validations' do
    it 'has a valid factory' do
      expect(build(:company)).to be_valid
    end

    it 'requires a name' do
      expect(build(:company, name: nil)).to_not be_valid
    end

    it 'requires a unqiue name' do
      expect(create(:company, name: 'phoenixfire')).to be_valid
      expect(build(:company, name: 'phoenixfire')).to_not be_valid
    end

    it 'requires a unqiue name' do
      expect(create(:company, name: 'phoenixfire')).to be_valid
      expect(build(:company, name: 'PHOENIXFIRE')).to_not be_valid
    end
  end

  describe 'concering associations' do
    let(:company) { create(:company) }

    it 'has many users' do
      user_1 = create(:user, company: company)
      user_2 = create(:user, company: company)
      expect(company.users).to match_array([user_1, user_2])
    end

    it 'has many roles' do
      role_1 = create(:role, company: company)
      role_2 = create(:role, company: company)
      expect(company.roles).to match_array([role_1, role_2])
    end

    it 'has many leads' do
      lead_1 = create(:lead, company: company)
      lead_2 = create(:lead, company: company)
      expect(company.leads).to match_array([lead_1, lead_2])
    end
  end

  describe 'concerning ActiveRecord callbacks' do
    let(:company) { create(:company) }

    it 'nukes the users' do
      user = create(:user, company: company)
      company.destroy
      expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'nukes the roles' do
      role = create(:role, company: company)
      company.destroy
      expect { role.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'nukes the leads' do
      lead = create(:lead, company: company)
      company.destroy
      expect { lead.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
