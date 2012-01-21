# To change this template, choose Tools | Templates
# and open the template in the editor.

class Observation::States::Create < Observation::State

  @next_state = Observation::States::Scheduled
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    !(@observation.parallel.empty? || @observation.observers.empty? || @observation.date.nil?)
  end

  def short_message
    short = :planning
  end

  def long_message
    short = []
    short << :observers if @observation.observers.empty?
    short << :parallel if @observation.parallel.empty?
    short << :date if @observation.date.nil?
  end

  def actions
    nil?
  end
end