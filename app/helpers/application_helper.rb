module ApplicationHelper

  def print_not_found(module_name, collection)

    if collection.empty?
      content_tag(:ul,
                 content_tag(:p, content_tag(:strong, I18n.t("#{module_name}.not_found")), class: "pObs txtCenter"),
                 class: "listOptions" )
    end
  end

  def flash_class(level)
    case level.to_sym
      when :notice  then "alert alert-info"
      when :success then "alert alert-success"
      when :error   then "alert alert-danger"
      when :alert   then "alert alert-danger"
    end
  end


end
