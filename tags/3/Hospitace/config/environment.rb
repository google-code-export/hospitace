# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hospitace::Application.initialize!

ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.delivery_method = :sendmail
#ActionMailer::Base.perform_deliveries = true

#ActionMailer::Base.sendmail_settings = {
#
#  :location => "/usr/sbin/sendmail",
#  :arguments => "-i -t"
#
#}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address        => 'smtp.gmail.com',
    :port           => 587,
    :domain         => 'kvalitavyuky.felk.cvut.cz',
    :authentication => :plain,
    :user_name      => 'kvalitavyuky@gmail.com',
    :password       => 'kleslo123'
}