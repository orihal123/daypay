class Category2 < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: '食費' },
    { id: 3, name: '外食' },
    { id: 4, name: '日用品' },
    
    
  ]

  include ActiveHash::Associations
  has_many :expenses
end
