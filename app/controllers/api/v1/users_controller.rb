class Api::V1::UsersController < Api::BaseController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    json_response(@users)
  end

  def show
    json_response(@user)
  end

  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  def update
    @user.update!(user_params)
    json_response(@user, :updated)
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def active_transaction
    @user = Customer.find(params[:user_id])
    @transaction = @user.active_transaction || {}

    json_response(@transaction)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
