class Item < ApplicationRecord
  CATEGORIES = ['Technology', 'Sporting Goods', 'Baby & Children', 'Home & Garden', 'Fashion', 'Vehicles', 'Office', 'Games', 'Furniture']

  belongs_to :user
end
