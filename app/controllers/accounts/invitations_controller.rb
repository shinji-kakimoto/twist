#TODO モジュールとクラスはなにが違うのか...?どこかで再利用するのか？
module Accounts
  class InvitationsController < Accounts::BaseController
    # ユーザのログイン
    skip_before_action :authenticate_user!, only: [:accept, :accepted]
    skip_before_action :authorize_user!, only: [:accept, :accepted]
    # 自前のower権限チェック
    before_action :authorize_owner!, except: [:accept, :accepted]

    def new
      @invitation = Invitation.new
    end

    def create
      @invitation = current_account.invitations.new(invitation_params)
      @invitation.save
      # TODO: developmentでは送れない。
      InvitationMailer.invite(@invitation).deliver_later
      flash[:notice] = "#{@invitation.email} has been invited."
      redirect_to root_url
    end

    # リンク先でここにくる
    def accept
      store_location_for(:user, request.fullpath)
      @invitation = Invitation.find_by(token: params[:id])
    end

    def accepted
      @invitation = Invitation.find_by(token: params[:id])

      if user_signed_in?
        user = current_user
      else
        user_params = params[:user].permit(
          :email,
          :password,
          :password_confirmation
        )

        user = User.create!(user_params)
        sign_in(user)
      end
      current_account.users << user
      flash[:notice] = "You have joined the #{current_account.name} account."
      redirect_to root_url(subdomain: current_account.subdomain)
    end

    private

    def authorize_owner!
      unless owner?
        flash[:alert] = "Only an owner of an account can do that."
        redirect_to root_url(subdomain: current_account.subdomain)
      end
    end

    def invitation_params
      params.require(:invitation).permit(:email)
    end
  end
end
