require 'rails_helper'

RSpec.describe 'As a merchant employee' do
  describe "When I have clicked the link 'My Discounts'" do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      @discount1 = @merchant_1.discounts.create(percent: 0.10, quantity: 5)
      @discount2 = @merchant_1.discounts.create(percent: 0.20, quantity: 10)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it 'should see all of my discounts' do
      visit '/merchant/discounts'

      expect(page).to have_content('All My Discounts')
      within "#discount-#{@discount1.id}" do
        expect(page).to have_content("Discount-#{@discount1.id}")
        expect(page).to have_content("Percentage: #{(@discount1.percent * 100).to_i}%")
        expect(page).to have_content("Quantity: #{@discount1.quantity}")
      end

      within "#discount-#{@discount2.id}" do
        expect(page).to have_content("Discount-#{@discount2.id}")
        expect(page).to have_content("Percentage: #{(@discount2.percent * 100).to_i}%")
        expect(page).to have_content("Quantity: #{@discount2.quantity}")
      end
    end
  end
end