class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    #Caches the dashboard data
    dashboard_service = DashboardService.new(current_user)
    dashboard_data = dashboard_service.dashboard_data

    dashboard_data = DashboardService.new(current_user).dashboard_data
    @active_people_pie_chart = dashboard_data[:active_people_pie_chart]
    @total_debts = dashboard_data[:total_debts]
    @total_payments = dashboard_data[:total_payments]
    @balance = dashboard_data[:balance]
    @last_debts = dashboard_data[:last_debts]
    @last_payments = dashboard_data[:last_payments]
    @my_people = dashboard_data[:my_people]
    @top_person = dashboard_data[:top_person]
    @bottom_person = dashboard_data[:bottom_person]
  end
end