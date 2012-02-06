class ContactController < ApplicationController
  skip_authorization_check
  
  def contact
    respond_to do |format|
      format.js
      format.html # index.html.erb
    end
  end

end
