class PersonMailer < ApplicationMailer
    def balance_report(person, people)
        @person = person
        @people = people
        mail(to: @person.email, subject: "Seu relatório aqui") do |format|
            format.html
          end
    end
end