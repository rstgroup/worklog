class FrontendController < ApplicationController
  def index
    @signup = Signup.new
  end
end