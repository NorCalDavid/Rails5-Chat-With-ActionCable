module FormHelper

	def form_error_messages!(resource)
    return "" if resource.nil? || resource.errors.empty?


    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <script>
      sweetAlert({ title: "#{sentence}", 
                   html: '<br />' +
                         '<h3 class="text-bold text-danger">#{messages}</h3>' +
                         '<br />', 
                   confirmButtonColor: "#FB404B",  
                   type: "error" });
    </script>
    <div id="error_explanation" class="error-message-block">
      <h3 class="error-message-title">#{sentence}</h3>
      <ul class="error-message-details">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
  
end
