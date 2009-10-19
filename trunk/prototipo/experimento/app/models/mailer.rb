class Mailer < ActionMailer::Base
  
  def invitation(invitation, signup_url)
    subject    'Convite para o experimento'
    recipients invitation.recipient_email
    from       'nossotf@googlegroups.com'
    body       :invitation => invitation, :signup_url => signup_url
    invitation.update_attribute(:sent_at, Time.now)
  end

end
