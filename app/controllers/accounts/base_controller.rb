module Accounts
  class BaseController < ApplicationController
    # d. authenticate: prove or show to be true or genuine
    # ユーザIDとパスワードで「認証」する
    before_action :authenticate_user!
    # d. authorize: give official permission for or approval to
    # ある情報へのアクセスを「認可」する
    before_action :authorize_user!


    # 認証はUserで行って、subdomainに対応するAccountを取得する
    def current_account
      @current_account ||= Account.find_by!(subdomain: request.subdomain)
    end
    helper_method :current_account

    def owner?
      # Accountモデルから取得したレコードの外部キーがUserと一致しているか。
      # なので、ownerIDがないと、一致しているかチェックできない。
      current_account.owner == current_user
    end
    helper_method :owner?

    private

    # subdomainに対するユーザ認可
    def authorize_user!
      authenticate_user!
      unless current_account.owner == current_user ||
             current_account.users.exists?(current_user.id)
      flash[:notice] = "You are not permitted to view that account."
      redirect_to root_url(subdomain: nil)
      end
    end

    # TODO: 自前で色々権限設定をやっている感じなのかな？Punditで代替可能？
    def authorize_owner!
      unless owner?
        flash[:alert] = "Only an owner of an account can do that."
        redirect_to root_url(subdomain: current_account.subdomain)
      end
    end
  end
end


