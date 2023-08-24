class Category2 < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: 'Food expenses' },
    { id: 3, name: 'Entertainment expenses' },
    { id: 4, name: 'Others' }

  ]

  include ActiveHash::Associations
  has_many :expenses
end
