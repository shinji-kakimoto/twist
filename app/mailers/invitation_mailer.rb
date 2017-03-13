class InvitationMailer < ApplicationMailer
  # HACK: クラス名とファイル名が一致して無くてハマった。
  def invite(invitation, account)
    @invitation = invitation
    @account = account
    mail(
      to: invitation.email,
      subject: "Invitation to join #{account.name} on Twist"
    )
  end
end
