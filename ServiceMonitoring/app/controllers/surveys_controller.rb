class SurveysController < InheritedResources::Base

  private

    def survey_params
      params.require(:survey).permit(:name, :reference_number, :version, :enable_flg, :provider_name, :language_avaliable, :start_date, :end_date)
    end
end

