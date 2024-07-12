class User::CsvImportsController < ApplicationController
  def new
    render 'new', locals: {
      csv_import: User::CsvImport.new
    }
  end

  def create
    csv_import = User::CsvImport.new(csv_import_params)

    if csv_import.valid?
      csv_import.import

      render partial: 'csv_import', locals: {
        csv_import:
      }
    else
      render 'new', locals: {
        csv_import:
      }, status: :unprocessable_entity
    end
  end

  private

  def csv_import_params
    params.permit(user_csv_import: [:file])[:user_csv_import]
  end
end
