class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    
    if @user.save!
      journal_entries = @user.journal_entries.create([
        { title: 'Sample Text', content: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium great turbulent clouds intelligent beings paroxysm of global death Cambrian explosion birth. Tesseract bits of moving fluff take root and flourish vel illum qui dolorem eum fugiat quo voluptas nulla pariatur stirred by starlight the carbon in our apple pies. Consectetur bits of moving fluff dream of the mind\'s eye the carbon in our apple pies dream of the mind\'s eye a still more glorious dawn awaits and billions upon billions upon billions upon billions upon billions upon billions upon billions.'},
        { title: 'Sample Text 2', content: "Of course, the Enchantment Under The Sea Dance they're supposed to go to this, that's where they kiss for the first time. Hey, Doc? Doc. Hello, anybody home? Einstein, come here, boy. What's going on? Wha- aw, god. Aw, Jesus. Whoa, rock and roll. Yo Right, okay, so right around 9:00 she's gonna get very angry with me. I don't know, Doc, I guess she felt sorry for him cause her did hit him with the car, hit me with the car. oh yeah, all you gotta do is go over there and ask her."},
      ])

      sign_in(@user)

      render json: {
          user: @user
      }, 
      status: 201
    else 
      render json: {errors: @user.errors.full_messages}
    end
  end

  def update
      begin
        @user.update(user_params)
      rescue Exception 
        render json: {
          message: "There was some other error" 
        }, 
        status: 500
      end
  end

  def destroy
    begin
      @user.destroy
      render json: {
        message: "user account deleted"
       }
    rescue Exception 
      render json: {
        message: "There was some other error" 
      }, 
      status: 500
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, user_id: [:title, :content])
    end
end
