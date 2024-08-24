# frozen_string_literal: true

module ApplicationHelper
  def inline_edit(object, field)
    link_data = object[field].blank? ? "blank" : object[field]
    tag.span(class: "inline-edit", data: { controller: "iedit" }) do
      concat(link_to(link_data, "#edit", data: { action: "iedit#edit", iedit_target: "data" }))
      concat(inline_edit_form(object, field))
    end
  end

  def inline_edit_form(object, field)
    tag.div(class: "inline-edit-form", data: { iedit_target: "form" }) do
      concat(tag.div(class: "form-group") do
        concat(form_with(model: object, url: admin_customer_path(object), method: :patch) do |f|
          concat f.text_field(field, class: "form-control", autocomplete: :off, data: { action: "keydown.esc->iedit#close" })
        end)
        concat(tag.div(class: "controls") do
          concat(link_to "E", "#Edit", class: "btn btn-sm btn-outline-primary")
          concat(link_to "C", "#Cancel", data: { action: "iedit#cancel" })
        end)
      end)
    end
  end
end



