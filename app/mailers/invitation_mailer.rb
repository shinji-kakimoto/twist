class InvitationMailer < ApplicationMailer
  # HACK: クラス名とファイル名が一致して無くてハマった。
  def invite(invitation)
    @invitation = invitation
    mail(
      to: invitation.email,
      subject: "Invitation to join #{invitation.account.name} on Twist"
    )
  end
end
