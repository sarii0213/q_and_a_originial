class Admin::QuestionsController < Admin::BaseController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy!
    flash[:info] = "質問「#{@question.title}」を削除しました"
    redirect_to admin_questions_path
  end
end
