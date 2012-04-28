require 'app_config'

class EvaluationMailer < ActionMailer::Base
  default from: "noreply@kvalitavyuky.felk.cvut.cz"

  def email_template(peoples,email_template,objects = {})
    return nil if email_template.nil?
    emails = peoples.uniq.collect { |item| item.email }.compact
    mail(
      :to => "osmman@gmail.com",
      :subject => email_template.subject
    )do |format|
      format.text { render 'email_template', :locals => { :email_template => email_template, :to => peoples, :objects=>objects }}
    end.deliver
  end
end
