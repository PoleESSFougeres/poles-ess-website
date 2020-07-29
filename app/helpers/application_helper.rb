module ApplicationHelper

  def model_is_defined(model_name)
    model_file_path = Rails.root.join("app/models/#{model_name.underscore}.rb")

    File.exist?(model_file_path)
  end

  # NOTIFICATIONS FLASH ##########################################################

  FLASH_BS_TYPES = {
    error: "danger",
    alert: "warning",
    warning: "warning",
    notice: "success"
  }.freeze

  # Affichage des notifications flash s'il y en a.
  #
  def flash_messages
    result = ""

    FLASH_BS_TYPES.each_key do |type|
      if flash[type].present?
        result = content_tag :div, "", class: "flash-message", data: { controller: 'flash' } do
          content_tag(:div, flash[type], class: "alert alert-#{FLASH_BS_TYPES[type]}") do
            concat(content_tag(:span,  flash[type]))
            concat(content_tag(:button, "", class: "close", data: {dismiss: 'alert', action: 'click->flash#close'}, aria: {label: 'Close'}) do
              content_tag(:i, '', class: "fas fa-times", aria: {hidden: 'true'})
            end)
          end
        end
        break
      end
    end
    flash.discard

    result
  end


end
