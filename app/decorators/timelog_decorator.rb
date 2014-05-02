class TimelogDecorator < ApplicationDecorator
  delegate_all

  def user
    model.user.decorate
  end
end
