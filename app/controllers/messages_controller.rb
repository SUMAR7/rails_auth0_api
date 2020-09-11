class MessagesController < SecuredController
  # skipping the authentication
  skip_before_action :authorize_request, only: [:show, :index]

  def index
    render json: Message.all
  end

  def show
    message = Message.find_by(id: params[:id])
    if message.present?
      render json: message
    else
      render json: {success: false, message: 'invalid message id'}
    end
  end

  def create
    message = Message.create!(message_params)
    render json: message, status: :created
  end

  def destroy
    message = Message.find_by(id: params[:id])
    if message&.destroy
      render json: {success: true, message: 'deleted successfully'}
    else
      render json: {success: false, message: 'something went wrong'}
    end
  end

  private

  def message_params
    params.permit(:body, :published)
  end
end
