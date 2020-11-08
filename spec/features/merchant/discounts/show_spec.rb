require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'When I visit my discount show page' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218, email: 'megan@example.com', password: 'securepassword')
      @discount1 = @merchant_1.discounts.create(percent: 0.10, quantity: 5)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it 'should see the discounts info' do
      visit "/merchant/discounts/#{@discount1.id}"

      expect(page).to have_content("Discount-#{@discount1.id}")
      expect(page).to have_content("Percentage: #{(@discount1.percent * 100).to_i}%")
      expect(page).to have_content("Quantity: #{@discount1.quantity}")
    end

    it 'should see the link to edit the discount' do
      visit "/merchant/discounts/#{@discount1.id}"

      expect(page).to have_link('Edit Discount')

      click_link 'Edit Discount'
      expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit")
    end
  end
end
