class Public::ResidentsController < ApplicationController
  def show
    @myevents = current_resident.myevents
  end
end
