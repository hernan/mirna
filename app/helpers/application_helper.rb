# frozen_string_literal: true

module ApplicationHelper
  def ftext(form, field, label:)
    tag.div class: "form-field-group" do
      options = {}
      options["aria-invalid"] = true if has_error?(form, field)

      concat form.label(field, label)
      concat form.text_field(field, options)
      concat form_error_message(form, field)
    end
  end

  def fselect(form, field, label:, options:)
    tag.div class: "form-field-group" do
      html_options = {}
      html_options["aria-invalid"] = true if has_error?(form, field)

      concat form.label(field, label)
      concat form.select(field, options, html_options)
      concat form_error_message(form, field)
    end
  end

  def fsubmit(form, label:, kind: "btn-primary")
    tag.div class: "form-field-group" do
      concat form.submit(label, class: kind)
    end
  end

  def fpassword(form, field, label:)
    tag.div class: "form-field-group" do
      options = {}
      options["aria-invalid"] = true if has_error?(form, field)

      concat form.label(field, label)
      concat form.password_field(field, options)
      concat form_error_message(form, field)
    end
  end

  def show_flash_messages
    return unless flash.any?

    tag.div class: "my-4 pb-2" do
      flash.each do |name, message|
        concat tag.p(message, class: "flash-msg-#{name}")
      end
    end
  end

  def form_error_message(form, field)
    return if form.object&.errors&.[](field).blank?

    tag.small do
      concat form.object.errors[field].join(", ")
    end
  end

  def has_error?(form, field)
    form.object.errors[field].present?
  end
end
