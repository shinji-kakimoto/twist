class Account < ActiveRecord::Base
  validates :subdomain, presence: true, uniqueness: true
  #TODO: User側にHas oneはいらないのか？
  #AccountのownerがUserクラス
  # ひとつのアカウントにつき正確に一人のユーザを割り当てる
  belongs_to :owner, class_name: "User"
  # @example
  #   AccountはUserの0個以上のインスタンスを所有しないので下記は書かない。
  #   NG: has_many :memberships
  #   NG: has_many :users, throught: :memberships
  #TODO 子から親を作るってこと？
  accepts_nested_attributes_for :owner

  has_many :invitations
  has_many :memberships
  has_many :users, through: :memberships
end
