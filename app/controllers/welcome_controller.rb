# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    render inline: "Welcome"
  end
end
