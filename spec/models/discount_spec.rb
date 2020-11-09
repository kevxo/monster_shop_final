require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it {should validate_uniqueness_of(:percent).scoped_to(:merchant_id)}
  end
end