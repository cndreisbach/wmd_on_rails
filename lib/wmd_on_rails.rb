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

    def create_wmd(textarea_id, preview_id = nil)
      js = <<EOF
var textarea = document.getElementById(#{textarea_id.inspect});
EOF
      if preview_id
        js += <<EOF
var preview = document.getElementById(#{preview_id.inspect});
var panes = {input: textarea, preview: preview, output: null};
var previewManager = new Attacklab.wmd.previewManager(panes);
var editor = new Attacklab.wmd.editor(textarea, previewManager.refresh);
EOF
      else
        js += <<EOF
var editor = new Attacklab.wmd.editor(textarea);
EOF
      end

      javascript_tag js
    end
  end
end
