require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe 'user permissions when they have a role assigned to them' do
    before(:each) do
      @company_1 = create(:company, name: 'Company 1')
      @company_2 = create(:company, name: 'Company 2')

      @user_1 = create(:user, company: @company_1)
      @user_2 = create(:user, company: @company_1)
      @user_3 = create(:user, company: @company_2)

      @company_1.create_default_roles
      @company_2.create_default_roles

      # Give Roles
      @role_1 = @company_1.roles.get('sales-representative')
      @user_1.roles << @role_1
      @user_2.roles << @role_1

      # Roles are scoped to the company_id
      @role_2 = @company_2.roles.get('sales-representative')
      @user_3.roles << @role_2

      # TODO: DRY these specs up
      @lead_1 = create(:lead, company: @company_1, assignable: @user_1)
      @lead_2 = create(:lead, company: @company_1, assignable: @user_2)
      @lead_3 = create(:lead, company: @company_2, assignable: @user_3)
    end

    it 'ensures user_1 has the right role' do
      expect(@user_1.roles).to match_array([@role_1])
    end

    it 'ensures user_2 has the right role' do
      expect(@user_2.roles).to match_array([@role_1])
    end

    it 'ensures user_3 has the right role' do
      expect(@user_3.roles).to match_array([@role_2])
    end

    # They don't have any roles
    it 'allows them to view their own User account' do
      expect(@user_1.can?(:show, @user_1)).to be_truthy
    end

    it 'prevents them from viewing other users in the same company' do
      expect(@user_1.can?(:show, @user_2)).to be_falsey
    end

    it 'prevents them from viewing other users in a different company' do
      expect(@user_1.can?(:show, @user_3)).to be_falsey
    end

    # CAUTION: You can't compare agains the CLASS itself with a list/block of conditions!
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/Checking-Abilities.md#checking-with-class
    it 'handles the User class itself' do
      expect(@user_1.can?(:show, User)).to be_truthy
    end

    context 'user_1 and assigned leads' do
      it 'they can see leads assigned to themselves' do
        expect(@user_1.can?(:manage, @lead_1)).to be_truthy
      end

      it 'prevents them from managing other leads in the company' do
        expect(@user_1.can?(:manage, @lead_2)).to be_falsey
      end

      it 'prevents them from managing leads outside the company' do
        expect(@user_1.can?(:manage, @lead_3)).to be_falsey
      end
    end

    context 'user_2 and assigned leads' do
      it 'they can see leads assigned to themselves' do
        expect(@user_2.can?(:manage, @lead_2)).to be_truthy
      end

      it 'prevents them from managing other leads in the company' do
        expect(@user_2.can?(:manage, @lead_1)).to be_falsey
      end

      it 'prevents them from managing leads outside the company' do
        expect(@user_2.can?(:manage, @lead_3)).to be_falsey
      end
    end

    context 'user_3 and assigned leads' do
      it 'they can see leads assigned to themselves' do
        expect(@user_3.can?(:manage, @lead_3)).to be_truthy
      end

      it 'prevents them from managing other leads in the company' do
        expect(@user_3.can?(:manage, @lead_1)).to be_falsey
      end

      it 'prevents them from managing leads outside the company' do
        expect(@user_3.can?(:manage, @lead_2)).to be_falsey
      end
    end
  end
end
