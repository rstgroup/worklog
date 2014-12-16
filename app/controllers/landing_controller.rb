class LandingController < ApplicationController
  def index
    @signup = Signup.new
  end
end
