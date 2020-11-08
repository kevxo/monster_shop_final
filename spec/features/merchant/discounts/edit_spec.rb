require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'When I edit a discount' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218, email: 'megan@example.com', password: 'securepassword')
      @discount1 = @merchant_1.discounts.create(percent: 0.10, quantity: 5)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it 'should be able edit the percent or quantity' do
      visit "/merchant/discounts/#{@discount1.id}/edit"

      expect(page).to have_content('Update Discount')

      percent = 0.50
      quantity = 8

      fill_in :percent, with: percent
      fill_in :quantity, with: quantity
      click_button 'Update Discount'

      expect(current_path).to eq("/merchant/discounts/#{@discount1.id}")
      expect(page).to have_content('Discount Updated')
    end

    it 'should not update discount' do
      visit "/merchant/discounts/#{@discount1.id}/edit"

      expect(page).to have_content('Update Discount')

      fill_in :percent, with: @discount1.percent

      click_button 'Update Discount'

      expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit")
      expect(page).to have_content("Discount Percent already in use or Discount Quantity already in use")

      fill_in :quantity, with: @discount1.quantity
      click_button 'Update Discount'

      expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit")
      expect(page).to have_content("Discount Percent already in use or Discount Quantity already in use")
    end
  end
end