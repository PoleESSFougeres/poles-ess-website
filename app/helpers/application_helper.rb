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

  def safe_l(date, hash = {})
    date && !date.blank? ? I18n.l(date, **hash) : nil
  end

  def number_to_euro(amount)
    number_to_currency(amount, locale: :fr, precision: 1, strip_insignificant_zeros: true)
  end

  def fullname(model)
    [model.firstname, model.lastname].join(" ")
  end

  def boolean_text(bool)
    I18n.t(bool, scope: [:boolean, :text])
  end

  def boolean_checkmark(bool)
    I18n.t(bool, scope: [:boolean, :checkmark])
  end

  def class_name(item)
    item.class.model_name.human
  end

  def public_file_exists?(filename)
    File.file? "#{Rails.public_path}/#{filename}"
  end

  def filtering_in_progress(params)
    params[:by_theme].present? || params[:by_profile].present? || params[:by_post_category].present?
  end
end
