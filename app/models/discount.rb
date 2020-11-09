class Discount < ApplicationRecord
  belongs_to :merchant
  validates_uniqueness_of :percent, scope: :merchant_id
end
