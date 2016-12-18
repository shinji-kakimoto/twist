class Account < ActiveRecord::Base
  validates :subdomain, presence: true, uniqueness: true
  #TODO: User側にHas oneはいらないのか？
  #AccountのownerがUserクラス
  # ひとつのアカウントにつき正確に一人のユーザを割り当てる
  belongs_to :owner, class_name: "User"
  has_many :invitations
  # HACK: え、usersあったぞ。。。
  has_many :memberships
  has_many :users, through: :memberships
  has_many :books
  #TODO 子から親を作るってこと？
  accepts_nested_attributes_for :owner
end
