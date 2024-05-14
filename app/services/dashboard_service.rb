class DashboardService
    def initialize(user)
      @user = user
    end
  
    def dashboard_data
      Rails.cache.fetch("#{cache_key}/dashboard_data", expires_in: 10.minutes) do
      {
        active_people_pie_chart: active_people_pie_chart,
        total_debts: total_debts,
        total_payments: total_payments,
        balance: balance,
        last_debts: last_debts,
        last_payments: last_payments,
        my_people: my_people,
        top_person: top_person,
        bottom_person: bottom_person
      }
    end
  end
    
    private

    def cache_key
      "dashboard_data/#{@user.id}"
    end
  
    def active_people_pie_chart
      {
        active: active_people_count(true),
        inactive: active_people_count(false)
      }
    end
  
    def active_people_count(active)
      Person.where(active: active).count
    end
  
    def total_debts
      Debt.where(person_id: active_people_ids).sum(:amount)
    end
  
    def total_payments
      Payment.where(person_id: active_people_ids).sum(:amount)
    end
  
    def balance
      total_payments - total_debts
    end
  
    def last_debts
      Debt.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  
    def last_payments
      Payment.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  
    def my_people
      Person.where(user: @user).order(created_at: :asc).limit(10)
    end
  
    def active_people_ids
      Person.where(active: true).select(:id)
    end
  
    def top_person
      Person.where('balance > 0').order(:balance).last
    end
  
    def bottom_person
      Person.where('balance > 0').order(:balance).first
    end
  end
