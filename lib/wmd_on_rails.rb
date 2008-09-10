module WmdOnRails
  module EditorHelper
    def enable_wmd(user_params = {})
      default_params = {
        :output => 'Markdown'
      }
      params = default_params.merge(user_params)
      
      output = javascript_tag "wmd_options = #{params.to_json}"
      output += javascript_include_tag "wmd/wmd"
      output
    end
    
    def wmd_preview(params = {})
      params = { :tag => :div, :class => '' }.merge(params)
      
      tag = params[:tag]
      html_class = params[:class].split(/\s+/).push('wmd-preview').join(" ")
      
      content_tag(tag, '', :class => html_class)
    end
  end
end