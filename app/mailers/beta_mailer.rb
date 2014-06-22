class BetaMailer < ActionMailer::Base
  default from: "Darren@BestTimeApp.com"

  def welcome_email(beta_user)

  	#attachments.inline['emaillogo'] = File.read(Rails.root.join('public/images/best_time_logo_text_only.png'))
	@beta_user = beta_user
    #mail(to: @beta_user.email, subject: 'Welcome to BestTime')
    mail(:to =>  @beta_user.email,
         :subject => 'Welcome to BestTime') do |format|
      format.html
      format.text
    end
  end
end
