class AnswerMailer < ApplicationMailer
  def create_email(answer:, question:, user:)
    @answer = answer
    @question = question
    mail(
      subject: '新規回答通知',
      to: user.email,
    )
  end
end
