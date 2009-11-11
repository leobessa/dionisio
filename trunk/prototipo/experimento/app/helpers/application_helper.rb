# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def phase_description_status 
    content_tag :h2, "Etapa #{current_user.stage_number} - Andamento #{current_user.stage_progress}/#{current_user.stage_limit}"
  end
end
