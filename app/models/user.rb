class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # HACK: 多対多の関係でもないのに、has_many: throughにするの？
  # -> membershipで関連付けられたaccountsが取得可能になる。(scopeが設定される)
  #    ※has_many :accountsだと全てを取得してしまう。
  #    has_many, belongs_toでER図は捉え方が微妙に違うのかもしれない。
  has_many :memberships
  # Accountsの「0個以上の」インスタンスを所有する
  has_many :accounts, through: :memberships

  def owned_account
    Account.where(owner: self)
  end

  def all_accounts
    owned_account + accounts
  end
end
