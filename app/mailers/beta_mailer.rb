class BetaMailer < ActionMailer::Base
  default from: "Darren@BestTimeApp.com"

  def welcome_email(beta_user)
	@beta_user = beta_user
    mail(to: @beta_user.email, subject: 'Welcome to BestTime')
  end
end
