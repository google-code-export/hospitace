class EvaluationMailer < ActionMailer::Base
  default from: "noreply@kvalitavyuky.felk.cvut.cz"

  def email_template(peoples,email_template,objects = {})
    return nil if email_template.nil?
    emails = ["osmman@gmail.com"]
    #emails = users.uniq.collect { |item| item.email }.compact
    mail(
      :to => emails,
      :subject => email_template.subject
    )do |format|
      format.text { render 'email_template', :locals => { :email_template => email_template, :to => peoples, :objects=>objects }}
    end.deliver
  end
end
