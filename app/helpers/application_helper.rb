module ApplicationHelper
  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def full_title page_title = ""
    base_title = t "titles.header"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def render_pagination collection
    paginate collection, theme: "twitter-bootstrap-3", pagination_class: "pagination-sm"
  end

  def flash_message flash_type
    t "flashs.messages.#{flash_type}", model_name: controller_name.classify
  end

  def link_to_add_fields label, f, assoc
    new_obj = f.object.class.reflect_on_association(assoc).klass.new
    fields = f.fields_for assoc, new_obj,child_index: "new_#{assoc}" do |builder|
      render "#{assoc.to_s.singularize}_fields", f: builder
    end
    link_to label, "#", class: "add-button fa fa-plus",
      onclick: "add_fields(this, \"#{assoc}\", \"#{escape_javascript(fields)}\")", remote: true
  end

  def link_to_remove_fields label, f
    field = f.hidden_field :_destroy
    link = link_to label, "#",
      class: "remove-button fa fa-trash text-danger",
      onclick: "remove_fields(this)", remote: true
    field + link
  end

  def page_index
    (((params[:page] || 1).to_i - 1) * Settings.pagination.per_page) + 1
  end
end
