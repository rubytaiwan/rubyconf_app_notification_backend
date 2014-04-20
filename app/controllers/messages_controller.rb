class MessagesController < ApplicationController
  http_basic_authenticate_with name: AppSetting.auth.name, password: AppSetting.auth.password.to_s

  helper_method :model_class
  def index
    @messages = Message.order('id DESC').all
    @message = Message.new
  end

  def new

  end

  def create

  end

protected

  def model_class
    Message
  end

end
