ActiveAdmin.register Scenario do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :question_id, :content

  form do |f|
    inputs 'Details' do
      input :question 
      input :content
      actions
    end
  end
  member_action :happened, method: :put do
    resource.update(happened: true)
    Questions::ComputeBetScoresService.new(resource.question).call

    redirect_to resource_path, notice: "Happened!"
  end

  action_item :happened, only: :show do
    unless scenario.happened
      link_to 'happened', happened_admin_scenario_path(scenario), method: :put
    end
  end
end
