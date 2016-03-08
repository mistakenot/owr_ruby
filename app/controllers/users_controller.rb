require 'pbkdf2'

class UsersController < ApplicationController
  before_action :authenticate_user!
  @iterations = 10000

  def index
    user = current_user
    @reviews = user.getReviews
  end

  def new
    @user = User.new
  end

  def create
    hash = PBKDF2.new do |p|
      p.password = params[:password]
      p.salt = "nacl"
      p.iterations = @iterations
    end

    params[:password_hash] = hash.hex_string
    params[:salt] = hash.salt

    @user = User.new(user_params)
    @user.save
    redirect_to ''
  end

  def show
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password_hash, :salt)
    end

end
