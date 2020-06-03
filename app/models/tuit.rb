class Tuit < ApplicationRecord
  belongs_to :parent, class_name: 'Tuit', optional: true
  belongs_to :owner, class_name: 'User'
end
