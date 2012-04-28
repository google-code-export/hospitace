class ErrorsController < ApplicationController
  def routing
    authorize! :show, "Errors"
    
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
