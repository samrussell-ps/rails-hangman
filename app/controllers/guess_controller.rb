class GuessController < ApplicationController
  def create
    redirect_to params[:game]
  end
end
