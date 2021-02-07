class Admin::ResidentsController < ApplicationController
  
  def index
    @residents = Resident.all
  end
end
