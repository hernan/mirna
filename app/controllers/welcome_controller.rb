class WelcomeController < ApplicationController
  def index
    render inline: "Welcome"
  end
end
