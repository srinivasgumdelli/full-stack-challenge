require 'rails_helper'

describe ResourceSite, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it 'validates uniqueness of name' do
      resource_site = FactoryGirl.build(:resource_site, name: "Site 1")
      expect(resource_site).to be_valid

      duplicate_site = FactoryGirl.create(:resource_site, name: "Site 1")
      expect(resource_site).to_not be_valid
    end
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:address) }
  end
end
