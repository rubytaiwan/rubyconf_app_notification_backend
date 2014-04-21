class MessagesController < ApplicationController
  http_basic_authenticate_with name: AppSetting.auth.name, password: AppSetting.auth.password.to_s

  helper_method :model_class, :messages
  def index
    @message = Message.new
  end

  def new

  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = 'Message successfully created!'
      redirect_to action: :index
    else
      render action: :index
    end
  end

protected

  def messages
    @messages ||= Message.order('id DESC').all
  end

  def message_params
    params.require(:message).permit(:title, :content)
  end

  def model_class
    Message
  end

end
