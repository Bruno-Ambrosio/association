class ReportsController < ApplicationController
  before_action :authenticate_user!

  def balance
    if current_user
      @people = Person.all
      PersonMailer.balance_report(current_user, @people).deliver_now
      redirect_to root_path, notice: 'Relatório enviado para seu e-mail'
    else
      redirect_to new_user_session_path, alert: 'Faça login para acessar esta funcionalidade.'
    end
  end
end