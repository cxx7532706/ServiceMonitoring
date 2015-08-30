class SurveysController < InheritedResources::Base

  #----------------------- Active Admin --------------------------#
  # Scopes for admin index
  scope :enabled, -> { where(enable_flg: true) }

  private

    def survey_params
      params.require(:survey).permit(:name, :reference_number, :version, :enable_flg, :provider_name, :language_avaliable, :start_date, :end_date)
    end
end

