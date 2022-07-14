class Admin::QuestionsController < Admin::BaseController
  def index
    @questions = Question.all
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy!
    flash[:info] = "質問「#{@question.title}」を削除しました"
    redirect_to admin_questions_path
  end
end
