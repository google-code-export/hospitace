class TestsController < ApplicationController
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
  session[:order_params] ||= {}
  @test = Test.new(session[:test_params])
  @test.current_step = session[:test_step]
  
    respond_to do |format|
      format.html # index.html.erb
    end
end

def create
  session[:test_params].deep_merge!(params[:test]) if params[:test]
  @test = Test.new(session[:test_params])
  @test.current_step = session[:test_step]
  if @test.valid?
    if params[:back_button]
      @test.previous_step
    elsif @test.last_step?
      @test.save if @test.all_valid?
    else
      @test.next_step
    end
    session[:test_step] = @test.current_step
  end
  if @test.new_record?
    render "new"
  else
    session[:test_step] = session[:test_params] = nil
    flash[:notice] = "Order saved!"
    redirect_to @test
  end
end


end
