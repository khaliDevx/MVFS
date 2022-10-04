class EmployeesController < ApplicationController
  layout 'application'
  before_action :check_login
  before_action :set_bass ,only: [:bass]
  before_action :check_type
  before_action :check_status
  # before_action :set_user ,only: [:edit]
  # before_action :confirm_employee_type, except: [:new, :create]

  def user
    @user = User.where(:id=>session[:user_id]) 
  end
  def block 
    respond_to do |format|
    
      if User.where(:id=>update_params[:id]).update_all(:accountstatu=>false)
          format.html { redirect_to '/user', notice: "this user are blocked." }
      else
        flash[:error_blook]="something went wrong"
        format.html { redirect_to '/user', notice: "something went wrong." }
      end
    end
  end
  def active
    # @user=User.find_by(id: active_params[:id])
    # @user.accountstatu=true
    respond_to do |format|
      if User.where(:id=>active_params[:id]).update_all(:accountstatu=>true)
        format.html { redirect_to '/user', notice: "this user are active." }
      else
        flash[:error_active]="something went wrong"
        format.html { redirect_to '/user', notice: "something went wrong." }
      end
    end
  end
  def pass
    # @problem = Problem.where(params[:id])
    # @problem = Problem.find_by(id: pass_params[:id])
    # @problem.status="Passed"
    if Problem.where(id:pass_params[:id]).update_all(:status=>"Passed")
      redirect_to '/issue'
    else
      redirect_to "/issue"
    end

  end
  def issue
    @user = User.where(:id=>session[:user_id]) 
    @problems = Problem.order("id DESC").issue_submitted.with_attached_image
  end
  def confirm
    # problem=Problem.find_by(id: confirm_params[:id])
    Problem.where(id:confirm_params[:id]).update_all(:status=>"Confirmed")
    respond_to do |format|
      format.html { redirect_to '/index', notice: "Photo was successfully created." }
    end
    # problem.status="Confirmed"
    # problem.update(confirm_params)
  end
  def report
    # @problems = Problem.with_attached_image.where(:status=>params[:status])
    # render 'reports'
  end
  def about

  end
  def report
    user = User.where(:id=>session[:user_id],:user_type=>"Employee")
    if user.present?
      @users = User.volunteer.where(["first_name LIKE ?","%#{params[:first_name]}%"])
    else
     @users = User.where(:user_type=>params[:type]).and(User.where(["first_name LIKE ?","%#{params[:first_name]}%"]))
    end
  end
  private

    def set_pass
     @problem = Problem.find(params[:id])
    end
    def set_user
     @user = User.find(params[:id])
    end
    def problem_params
     params.require(:problem).permit(:image, :cordinates,  :status, :desciption, :governorate_id, :category_id,:city_id,:user_id)  
    end
    def update_params
      params.require(:block).permit(:accountstatu,:id)  

    end
    def active_params
      params.require(:active).permit(:accountstatu,:id)  

    end
    def pass_params
      params.require(:pass).permit(:status,:id)  
    end
    def confirm_params
      params.require(:confirm_issue).permit(:status,:id)  
    end
    #  def select_params
    #   params.require(:select).permit(:status)  
    #  end
     
  
end
