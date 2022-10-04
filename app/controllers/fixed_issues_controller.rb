class FixedIssuesController < ApplicationController
  before_action :set_fixed_issue, only: %i[ edit update destroy ]

  # GET /fixed_issues or /fixed_issues.json
  def index
    @fixed_issues = FixedIssue.all.order("id DESC")
    @user = User.all
  end

  # GET /fixed_issues/1 or /fixed_issues/1.json
  def show
    @fixed_issues = FixedIssue.all

  end

  # GET /fixed_issues/new
  def new
    @fixed_issue = FixedIssue.new
    @accept = Accept.find_by(:user_id=>session[:user_id])
    @problem =Problem.find_by(:id=>@accept.problem_id)
  end

  # GET /fixed_issues/1/edit
  def edit
  end

  # POST /fixed_issues or /fixed_issues.json
  def create
    @fixed_issue = FixedIssue.new(fixed_issue_params)

    respond_to do |format|
      if @fixed_issue.save
        Problem.where(:id=>fixed_issue_params[:problem_id]).update_all(:status=>"Fixed")
        Accept.where(:problem_id=>fixed_issue_params[:problem_id]).update_all(:in_progress=>false)
        User.where(:id=>fixed_issue_params[:user_id]).update_all(:supervisor=>false)
        JoinIssue.where(:problem_id=>fixed_issue_params[:problem_id]).update_all(:status=>false)
        format.html { redirect_to '/fixed_issue', notice: "Fixed issue was successfully created." }
        # format.json { render :show, status: :created, location: @fixed_issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fixed_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fixed_issues/1 or /fixed_issues/1.json
  def update
    respond_to do |format|
      if @fixed_issue.update(fixed_issue_params)
        format.html { redirect_to fixed_issue_url(@fixed_issue), notice: "Fixed issue was successfully updated." }
        format.json { render :show, status: :ok, location: @fixed_issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fixed_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixed_issues/1 or /fixed_issues/1.json
  def destroy
    @fixed_issue.destroy

    respond_to do |format|
      format.html { redirect_to fixed_issues_url, notice: "Fixed issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixed_issue
      @fixed_issue = FixedIssue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fixed_issue_params
      params.require(:fixed_issue).permit(:image, :user_id, :problem_id, :description)
    end
end
