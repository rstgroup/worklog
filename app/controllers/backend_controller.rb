class BackendController < ApplicationController
  layout 'landing'
  before_filter :authenticate_user!
end