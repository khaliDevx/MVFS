class AdminController < ApplicationController
  def add_emoployee
    @city = City.all
  end
  def create 
    user=User.new(newuser_params)
    user.user_type="Employee"
    user.status=true
        if user.save
            redirect_to '/user'
        else
            flash[:error]=user.errors.full_messages
            redirect_to '/new_user'
        end
  end
  private
  def newuser_params
    params.require(:employee).permit(:first_name, :last_name, :phone, :username, :password, :city_id, :accountstatu, :status)  
    
  end
end
