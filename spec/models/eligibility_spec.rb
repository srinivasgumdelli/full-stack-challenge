require 'rails_helper'

describe Eligibility, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:eligibility) }
    it 'validates uniqueness of eligibility' do
      eligibility = FactoryGirl.build(:eligibility, eligibility: 'eligibility1')
      expect(eligibility).to be_valid

      duplicate_eligibility = FactoryGirl.create(:eligibility, eligibility: 'eligibility1')
      expect(eligibility).to_not be_valid
    end
    it { is_expected.to validate_presence_of(:description) }
  end
end
