# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hospitace::Application.initialize!

#TODO odstranit!!!!!!!!!!! docasne 
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.gmail.com',
    :domain         => 'kvalitavyuyky.felk.cvut.cz',
    :port           => 587,
    :user_name      => 'osmman@gmail.com',
    :password       => 'kulturak',
    :authentication => :plain
}
