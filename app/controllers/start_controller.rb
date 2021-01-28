class StartController < ApplicationController
  def index
    if user_signed_in?

      if !current_user.pobral

        for i in (1..3)
          nr = Question.where(gr: i).count
          p = rand(1..nr)
          @quest = Question.where(gr: i).offset(p-1).first
          xuid = current_user.id
          pyt = Egzam.new
          pyt.user_id = current_user.id
          pyt.question_id = @quest.id
          pyt.save!
        end
        current_user.pobral = true
        current_user.save!
      end
      @zestaw = Egzam.where(user_id: current_user.id).order(:gr)
      @user = current_user
    end
  end
end
