class ReportsController < ApplicationController
    before_action :authenticate_user!
  
    def balance
      begin
        PersonMailer.balance_report(current_user).deliver_later
        redirect_to root_path, notice: 'Relatório enviado para seu e-mail'
      rescue => e
        Rails.logger.error "Failed to send balance report: #{e.message}"
        redirect_to root_path, alert: 'Houve um problema ao enviar o relatório. Tente novamente mais tarde.'
      end
    end
  end
  