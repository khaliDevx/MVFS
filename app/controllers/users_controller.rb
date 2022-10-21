class UsersController < ApplicationController
     layout 'application'
    #  before_action :confirm, except: [:new, :create]
    before_action :check_status
    before_action :blok_or_active, only: %i[ accept_issue join]
    before_action :check_login

    def index
     @user = User.where(:id=>session[:user_id])
     user = User.find_by(:id=>session[:user_id])
     @employee= User.where(:id=>session[:user_id],:user_type=>"Employee").or(User.where(:id=>session[:user_id],:user_type=>"Admin"))
     @problems = Problem.issue_passed.order("id DESC").with_attached_image
     @issue=Problem.where(:id=>params[:problem_id])

    end
    def profile

      @employee= User.where(:id=>session[:user_id],:user_type=>"Employee")
      @city= City.all
      @gover= Governorate.all
      @problems=Problem.where(:user_id=> session[:user_id])
      @user = User.where(:id=>session[:user_id])
      @photo = Photo.find_by(user_id: session[:user_id])
    end
    def upimage
       if User.where(:id=>session[:user_id]).save(:image=>image_params[:image])
        redirect_to "/profile"
       else
        redirect_to '/index'
       end
    end
    def update_profile
        user=User.find_by(id: session[:user_id])
        if User.where(:id=> session[:user_id]).update_all(:city_id=>update_profile_params[:city_id])
            redirect_to "/profile"
        else
            flash[:error_city]="something went wrong"
            redirect_to '/profile'
        end
    end
    def update
        @user=User.find_by(id: update_params[:id])
        if User.where(:id=>update_params[:id]).update_all(:first_name=>update_params[:first_name],:last_name=>update_params[:last_name],:username=>update_params[:username],:phone=>update_params[:phone],:bio=>params[:bio])
            redirect_to "/profile"
        else
            flash[:error_profile]="something went wrong"

            redirect_to '/profile'
        end
    end
    def destroy
        @user=User.where(:id=>params[:id]).update_all(:status=>false)
        respond_to do |format|
            format.html { redirect_to '/user', notice: "Photo was successfully destroyed." }
            format.json { head :no_content }
        end

    end
    def log_out

        session[:user_id]=nil
        cookies[:user_type]=nil

        redirect_to '/'

    end
    def log
        user = User.find_by(id: session[:user_id])
        if user.user_type=="Employee"
            redirect_to '/issue'
        else
            redirect_to '/index'
        end
    end

    def confirmed_issue
     @user = User.where(:id=>session[:user_id])
     @employee= User.where(:id=>session[:user_id],:user_type=>"Employee")
     @mat = Material.all
     @accepter = User.find_by(:id=>session[:user_id], :supervisor=>true)
    end
    def accept_status
        @user = User.where(:id=>session[:user_id])
        user = User.find_by(:id=>session[:user_id])
        @problems = Problem.accept_issue.where(:city_id=>user.city_id).order("id DESC").with_attached_image
        @money = MoneyType.all
        @accepter = User.find_by(:id=>session[:user_id], :supervisor=>true)
    end

    def join
        join=JoinIssue.new(join_params)
        join.user_id=session[:user_id]
        join.status=true
        respond_to do |format|
            if join.save
                format.html { redirect_to '/accept_status', notice: "you are successfully joined ." }
            else
                flash[:error_join]="something went wrong"
                redirect_to '/accept_status'
            end
        end

    end
    def meassage

    end
    def personal_page
        if user = User.where(:id=>params[:id]).present?
            @users= User.where(:id=>params[:id])
            @employee = User.where(:id=>session[:user_id],:user_type=>"Employee")
        else
            redirect_to '/index'
        end
    end
    def add_bio
       if User.where(:id=> session[:user_id]).update_all(:bio=>bio_params[:bio])
        redirect_to new_photo_path
       else
        flash[:error_bio]="something went wrong"
        redirect_to new_photo_path
       end

    end

    def support_money
        support = SupportedMoney.new(money_params)
        respond_to do |format|
            if support.save
                format.html { redirect_to '/accept_status', notice: "supported was successfully created." }
            else
                flash[:error_supp]= "something went wrong"
                redirect_to '/accept_status'
            end
        end
    end

    def support_mat
        supportmat = MaterialSupporet.new(supmat_params)
        respond_to do |format|
            if supportmat.save
                format.html { redirect_to '/accept_status', notice: "supported was successfully created." }
            else
                flash[:error_supp]= "something went wrong"
                redirect_to '/accept_status'
            end
        end
    end
    def supervisor
        if @accept = Accept.find_by(:user_id=>session[:user_id], :problem_id=>Problem.where(:status=>"Accepted"))

            @accept = Accept.find_by(:user_id=>session[:user_id], :problem_id=>Problem.where(:status=>"Accepted"))
            @problem =Problem.find_by(:id=>@accept.problem_id)
            @x = @problem.id
            @supporter_mat = MaterialSupporet.where(:problem_id=>@problem.id)
            @supporter_m = SupportedMoney.where(:problem_id=>@problem.id)
            @user = User.where(:id=>session[:user_id])
            @current_user = User.find_by(:id=>session[:user_id])
            # @fix = Problem.find_by(:user_id=>session[:user_id])
        else
            redirect_to '/index'
        end
    end

    def accept_mat
        accept = AcceptMat.new(accmat_params)
        respond_to do |format|
            if accept.save
                format.html { redirect_to '/supervisor', notice: "supported was successfully created." }
            else
                redirect_to '/supervisor'
            end

        end
    end
    def accept_money
        accept = AcceptMoney.new(accmaney_params)
        respond_to do |format|
            if accept.save
                format.html { redirect_to '/supervisor', notice: "supported was successfully created." }
            else
                redirect_to '/supervisor'
            end
        end
    end
    def support
        @user = User.where(:id=>session[:user_id])
        user = User.find_by(:id=>session[:user_id])
        @problem = Problem.find_by(:id=>params[:id])
        @money = MoneyType.all
        @accepter = User.find_by(:id=>session[:user_id], :supervisor=>true)
        @problems = Problem.accept_issue.where(:city_id=>user.city_id).order("id DESC").with_attached_image
    end

    def changesuper
        User.where(id:chnge_params[:user_id]).update_all(:message=>true)
        redirect_to'/supervisor'
    end
    def rejectsup
        User.where(id:rejec_params[:user_id]).update_all(:message=>false)
        redirect_to'/index'

    end
    def conirmsup
        User.where(id:yes_params[:user_id]).update_all(:message=>false,:supervisor=>true)

        # User.where(id:yes_params[:user_id]).update_all(:message=>false,:spervisor=>true)
        join =JoinIssue.find_by(:user_id=>session[:user_id])
        accept = Accept.find_by(:problem_id=>join.problem_id)
        User.where(id:accept.user_id).update_all(:message=>false,:supervisor=>false)
        Accept.where(:problem_id=>join.problem_id).update_all(:user_id=>session[:user_id])
        JoinIssue.where(:user_id=>session[:user_id]).destroy_all
        redirect_to '/supervisor'
    end

    def accept_requst
        
    end
    private
        def issue_params
            params.require(:issue).permit(:id)
        end

         def set_login
             @user=User.find(params[:id])
         end
         def login_params
            params.require(:user).permit(:first_name, :last_name, :phone, :username, :password, :city_id, :accountstatu)
         end
         def update_params
            params.require(:edit_user).permit(:id,:first_name, :last_name, :username,:phone,:bio)
         end

         def update_profile_params
            params.require(:upprofile).permit(:city_id)
         end
         def join_params
            params.require(:join_issue).permit(:problem_id)
         end
         def  bio_params
            params.require(:bio).permit(:bio,:id)
         end
         def money_params
             params.require(:money).permit(:user_id, :problem_id, :amount, :money_type_id)
         end
         def supmat_params
             params.require(:supmat).permit(:user_id, :problem_id, :material_id, :quantity)
         end
         def accmat_params
            params.require(:accmat).permit(:user_id, :problem_id, :material_id, :quantity, :sup_id)
         end
         def accmaney_params
            params.require(:accmoney).permit(:user_id, :problem_id, :sup_id, :amount)
         end
         def chnge_params
            params.require(:chang).permit(:user_id)
         end
         def rejec_params
            params.require(:reject).permit(:user_id)
         end
         def yes_params
            params.require(:yes).permit(:user_id)
         end
end
