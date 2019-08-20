class OrderProduct < ApplicationRecord
  has_one :order
  has_one :product
end

