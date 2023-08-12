class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: '給与' },
    { id: 3, name: 'お小遣い' },
    { id: 4, name: 'その他' }

  ]

  include ActiveHash::Associations
  has_many :incomes
end
