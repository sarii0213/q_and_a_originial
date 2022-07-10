class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      flash[:notice] = '回答が登録されました'
      render 'questions/show'
    else
      flash[:danger] = '回答が登録できませんでした'
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body).merge(user_id: current_user.id)
  end
end
