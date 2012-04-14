class EvaluationMailer < ActionMailer::Base
  default from: "noreply@kvalitavyuky.felk.cvut.cz"

  def email_template(users,email_template,objects = {})
    return if email_template.nil?
    
    emails = users.uniq.collect { |item| item.email }
    
    mail(
      :to => emails,
      :subject => email_template.subject
    )do |format|
      format.text { render 'email_template', :locals => { :email_template => email_template, :users => users, :objects=>objects }}
    end
  end
end
