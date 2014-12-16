ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
  # add nokogiri gem to Gemfile
  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, input"
  elements.each do |e|
    if e.node_name.eql? 'label'
      html = %(<div class="clearfix error">#{e}</div>).html_safe
    elsif e.node_name.eql? 'input'
      if instance.error_message.kind_of?(Array)
        html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">#{instance.error_message.join('<br />')}</span></div>).html_safe
      else
        html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">#{instance.error_message}</span></div>).html_safe
      end
    end
  end
  html
end