class Category2 < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: 'food expenses' },
    { id: 3, name: 'entertainment expenses' },
    { id: 4, name: 'others' }

  ]

  include ActiveHash::Associations
  has_many :expenses
end
