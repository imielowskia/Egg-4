class ImportController < ApplicationController
  def lista
    @users = User.all
  end

  def import
    User.import(params[:file])
    redirect_to import_lista_path, notice: "Zaimportowano uzytkowników."
  end
end