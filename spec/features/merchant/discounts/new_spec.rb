require 'rails_helper'

RSpec.describe 'As a merchant employee' do
  describe "when I click the 'Create Discount' link" do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it 'should see a form to create a discount' do
      visit '/merchant/discounts/new'

      fill_in :percent, with: 0.10
      fill_in :quantity, with: 5
      click_button 'Submit'

      expect(current_path).to eq('/merchant/discounts')
    end

    it 'should not create a discount if quantity is < 5' do
      visit '/merchant/discounts/new'

      fill_in :percent, with: 0.10
      fill_in :quantity, with: 3
      click_button 'Submit'

      expect(current_path).to eq('/merchant/discounts/new')
      expect(page).to have_content('Could not create discount: quantity less than 5 or percent is incorrect')
    end
  end
end