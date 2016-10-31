class QuestionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :question, through: :user

  before_action :correct_user?
  before_action :load_subjects, only: [:new, :edit, :update, :create]

  def index
    @questions = current_user.questions.page params[:page]
  end

  def new
    @question.options.build
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      redirect_to user_questions_path(current_user), notice: flash_message("suggested")
    else
      render :new
    end
  end

  def show
    @options = @question.options
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      redirect_to user_questions_path(current_user), notice: flash_message("updated")
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:danger] = flash_message "not_deleted"
    end
    redirect_to user_questions_path current_user
  end

  private
  def question_params
    params.require(:question).permit Question::PARAMS_ATTRIBUTES
  end

  def load_subjects
    @subjects = Subject.all
  end

  def correct_user?
    redirect_to root_path unless current_user == @user
  end
end
