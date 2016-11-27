module Accounts
  class BaseController < ApplicationController
    before_action :authenticate_user!

    def current_account
      @current_account ||= Account.find_by!(subdomain: request.subdomain)
    end
    helper_method :current_account

    def owner?
      # Accountモデルから取得したレコードの外部キーがUserと一致しているか。
      current_account.owner == current_user
    end
    helper_method :owner?
  end
end
