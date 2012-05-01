# To change this template, choose Tools | Templates
# and open the template in the editor.

class Observation::States::Create < Observation::State

  @next_state = Observation::States::Scheduled
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    !(self.observation.parallel.nil? || self.observation.observers.empty? || self.observation.date.nil?)
  end

  def short_message
    short = "observation.states.create.short" #planning
  end
  
  def label
    "warning"
  end

  def long_message
    long = []
    long << "observation.states.create.observers" if @observation.observers.empty?
    long << "observation.states.create.parallel" if @observation.parallel.nil?
    long << "observation.states.create.date" if @observation.date.nil?
    return long
  end

  def actions
    actions = []
    actions << { :title=>"observation.states.create.actions.observers",:href=>"/observations/#{@observation.id}/observers" }if @observation.observers.empty? 
    actions << { :title=>"observation.states.create.actions.parallel",:href=>"/observations/#{@observation.id}/edit"} if @observation.parallel.nil?
    actions << { :title=>"observation.states.create.actions.date",:href=>"/observations/#{@observation.id}/edit"} if @observation.date.nil?
    return actions
  end
end