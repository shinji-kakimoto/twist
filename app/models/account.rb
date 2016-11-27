class Account < ActiveRecord::Base
  validates :subdomain, presence: true, uniqueness: true
  belongs_to :owner, class_name: "User"
  #TODO 子から親を作るってこと？
  accepts_nested_attributes_for :owner
end
