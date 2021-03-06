class InsurersController < ApplicationController
  load_and_authorize_resource

  private
  def insurer_params
    params.require(:insurer).permit(:name, :is_medicaid, :provider_ids)
  end
end
