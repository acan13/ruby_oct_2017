class EventsController < ApplicationController
  def index
    @events = State.find(current_user.state).events
    @other_events = Event.where.not(states:current_user.state.id)
    tester = Event.first.state
    puts '%%%%%%%%%%%%%%%%%'
    puts tester
    puts '%%%%%%%%%%%%%%%%%'
    @user = current_user
    @states = State.all
  end

  def show
  end

  def create
  end

  def destroy
  end
end
