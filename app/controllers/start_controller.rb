class StartController < ApplicationController
  before_action :set_user, only: %w[ show ]


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
      @zestaw = Egzam.where(user_id: current_user.id).order(:question_id)
      @user = current_user
    end
  end


  def show
    @zestaw = Egzam.where(user_id: @user.id).order(:question_id)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Egzamin: #{current_user.imie} #{current_user.nazwisko}",
        page_size: 'A4',
        template: "start/show.html.erb",
        layout: "pdf.html",
        orientation: "Portrait",
        lowquality: false,
        zoom: 1,
        dpi: 150,
        encoding: 'UTF-8'
      end


    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

end
