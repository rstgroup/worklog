class ClientDecorator < ApplicationDecorator
  delegate_all

  def users
    model.users.decorate
  end
end
