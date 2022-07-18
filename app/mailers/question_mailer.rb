class QuestionMailer < ApplicationMailer
  def create_email(question:, user:)
    @question = question
    mail(
      subject: '新規質問通知',
      to: user.email,
    )
  end
end
