class FrontendController < ApplicationController
  layout 'landing'
  def index
    @signup = Signup.new
  end
end