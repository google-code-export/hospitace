require 'test_helper'

class EvaluationMailerTest < ActionMailer::TestCase
    
  test "send template email" do
    #puts people(:turekto5).inspect
    
    p = people(:turekto5)
    email_template = email_templates(:a)
 
    # Send the email, then test that it got queued
    email = EvaluationMailer.email_template(p,email_template).deliver
    assert ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal [p.email], email.to
    assert_equal email_template.subject, email.subject
  end
end
