class TestController < ApplicationController
  def index
    authorize! :index, Observation
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
