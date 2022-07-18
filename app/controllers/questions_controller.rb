class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      @users = User.where.not(id: @question.user_id)
      @users.each do |user|
        QuestionMailer.create_email(question: @question, user: user).deliver_now
      end
      redirect_to question_path(@question), success: '質問を作成しました'
    else
      redirect_to new_question_path, error: '質問を作成できませんでした'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question), success: '質問を更新しました'
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to questions_path, success: "質問「#{@question.title}」を削除しました"
  end

  def unsolved
    @q = Question.where(solved: false).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
    render 'questions/index'
  end

  def solved
    @q = Question.where(solved: true).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
    render 'questions/index'
  end

  def solve
    @question = current_user.questions.find(params[:id])
    @question.update!(solved: true)
    redirect_to question_path(@question), success: '解決済みにしました'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
