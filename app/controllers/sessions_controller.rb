class SessionsController < ApplicationController
  layout 'login_signup'
    # before_action :check_status
    # before_action :check_status,  only: %i[ new log_in]
    #  before_action :confirm, except: [:login, :log_in]
    def new 
        @city=City.all 
    end
    def create 
        user=User.new(new_params)

        user.user_type="Volunteer"
        user.status=true
            if user.save
                cookies[:user_type]=user.user_type
                session[:user_id]=user.id

                redirect_to new_photo_path
            else
                flash[:error]=user.errors.full_messages
                redirect_to '/new'
            end
    end
    def create_user 
        user=User.new(newuser_params)
        user.user_type="Volunteer"
        user.employee_id=session[:user_id]
            if user.save
                # cookies[:user_type]=user.user_type
                # session[:user_id]=user.id
                redirect_to '/user'
            else
                flash[:error]=user.errors.full_messages
                redirect_to '/new_user'
            end
      end
    def login
        user=User.find_by(username: login_params[:username])
        if user && user.authenticate(login_params[:password])
            if user.user_type=="Admin"
                session[:user_id]=user.id
                cookies[:user_type]=user.user_type
                redirect_to '/user'
            elsif user.user_type=="Employee"
                session[:user_id]=user.id
                cookies[:user_type]=user.user_type
                redirect_to '/issue'
            else
                session[:user_id]=user.id
                cookies[:user_type]=user.user_type
                redirect_to '/index'

            end
        else
            flash[:error]="user not found!"
            redirect_to '/login'
        end
    end
    def log_in
        
    end
    def comment 
        feed=Coment.new(feed_prams)

        feed.user_id=session[:user_id]
        respond_to do |format|
            if feed.save 
                format.html { redirect_to '/index', notice: "comment was successfully created." }
                format.json { head :no_content }
              
            else
                flash[:error_feed]="something went wrong"
                redirect_to '/issue'
            end
        end
        
    end
    
    private
    def login_params
        params.require(:login).permit(:username,:password, :user_type)
    end
    def newuser_params
        params.require(:employee).permit(:first_name, :last_name, :phone, :username, :password, :city_id, :accountstatu)  
        
    end
    def new_params
        params.require(:user).permit(:first_name, :last_name, :phone, :username, :password, :city_id, :accountstatu)  
     end
    def feed_prams
        params.require(:feed).permit(:problem_id ,:user_id ,:comment)
     end
    
end
