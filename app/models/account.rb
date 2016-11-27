class Account < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  #TODO 子から親を作るってこと？
  accepts_nested_attributes_for :owner
end
