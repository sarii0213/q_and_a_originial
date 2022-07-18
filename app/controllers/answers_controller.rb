class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      other_answerers = @question.answers.map(&:user_id)
      users = User.where(id: @question.user_id).or(User.where(id: other_answerers)).where.not(id: @answer.user_id)
      # 質問投稿者 or 同質問の他の回答投稿者 and not 回答投稿者本人
      users.each do |user|
        AnswerMailer.create_email(answer: @answer, question: @question, user: user).deliver_now
      end
      flash[:success] = '回答しました'
      render 'questions/show'
    else
      flash[:error] = '回答が登録できませんでした'
      render 'questions/show'
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])
    @answer.destroy!
    redirect_to question_path(params[:question_id]), success: '回答を削除しました'
  end

  private

  def answer_params
    params.require(:answer).permit(:body).merge(user_id: current_user.id)
  end
end
