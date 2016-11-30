class Account < ActiveRecord::Base
  validates :subdomain, presence: true, uniqueness: true
  #TODO: User側にHas oneはいらないのか？
  belongs_to :owner, class_name: "User"
  #TODO 子から親を作るってこと？
  accepts_nested_attributes_for :owner

  has_many :invitations
  has_many :memberships
  has_many :users, through: :memberships
end
