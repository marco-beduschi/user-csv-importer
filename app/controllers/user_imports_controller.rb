class UserImportsController < ApplicationController
  def new
    render 'new', locals: {
      user_import: UserImport.new
    }
  end

  def create
    user_import = UserImport.new(user_import_params)

    if user_import.valid?
      user_import.import
    else
      render 'new', locals: {
        user_import:
      }, status: :unprocessable_entity
    end
  end

  private

  def user_import_params
    params.permit(user_import: [:file])[:user_import]
  end
end
