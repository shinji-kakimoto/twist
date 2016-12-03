class Invitation < ActiveRecord::Base
  belongs_to :account

  validates :email, presence: true

  before_create :generate_token

  # Tableの主キーを変更する(デフォルトはID1, 2など)
  def to_param
    token
  end

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end

end
