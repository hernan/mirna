# frozen_string_literal: true

class MyFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(method, options = {})
    field_wrapper(method, options) do
      super(method, options)
    end
  end

  def password_field(method, options = {})
    field_wrapper(method, options) do
      super(method, options)
    end
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    label_text = options.delete(:label)

    @template.content_tag(:label) do
      [
        super(method, options, checked_value, unchecked_value),
        label_text
      ].join.html_safe
    end
  end

  private
    def field_wrapper(method, options = {})
      options["aria-invalid"] = true if has_error?(method)

      @template.content_tag(:div, class: "form-field-group") do
        [
          @template.content_tag(:label, options.delete(:label), for: method),
          yield,
          (@template.content_tag(:small, object.errors[method].join(", ")) if has_error?(method))
        ].join.html_safe
      end
    end

    def has_error?(field)
      return false if object.blank?

      object.errors[field].any?
    end
end
