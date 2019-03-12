class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  	@user = User.new
  end

  def create
  	email = params[:session][:email]
  	password = params[:session][:password]

  	user = User.find_from_credentials(email, password)

  	if user
  		sign_in(user)
  		render json: {
  			message: "user with email #{email} is now logged in"
  		},
  		status: 200
  	else 
      	render json: {
      		message: "email or password entered is incorrect"
      	}, 
      	status: 400
      	@user = User.new(email: email)
  	end
  end

  def destroy
  	# begin
	  	sign_out(current_user)
	  	render json: {
			message: "user signed out"
		}
	# rescue Exception 
	#     render json: {
	#       message: "There was some other error" 
	#     }, 
 #        status: 500
 #    end
  end
end
