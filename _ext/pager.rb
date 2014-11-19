module Awestruct
  module Extensions
    class Pager
      
      def initialize(prop_name)
        @prop_name = prop_name
      end
      
      def execute(site)        
        site.send("#{@prop_name}=", self)
      end
      
      def links(page, window)
        all = page.pages
        if all.nil? or all.empty?
          return ""
        end
        
        current = page.current_page
        previous = page.previous_page
        nxt = page.next_page
        curr_idx = page.current_page_index
        
        html = ""
        
        html += singleLink("&laquo;", "disabled", curr_idx == 0, all[0])
        html += singleLink("&lsaquo;", "disabled", curr_idx == 0, previous)
        
        skip_previous = false
        skip_next = false
        
        all.each_with_index do |post, i|
          cls = "active"
          text = "#{i+1}"
          cond = i == curr_idx
          
          if cond
            html += singleLink(text, cls, cond, post)
          elsif i <= window
            html += singleLink(text, nil, false, post)
          elsif (i > window) && (i < (curr_idx - window)) && !skip_previous
            html += singleLink("&hellip;", "disabled", true, post)
            skip_previous = true
          elsif (i > (curr_idx + window)) && (i < ((all.size - window) - 1)) && !skip_next
            html += singleLink("&hellip;", "disabled", true, post)
            skip_next = true
          elsif (i >= (curr_idx - window)) && (i <= (curr_idx + window))
            html += singleLink(text, nil, false, post)
          elsif i >= ((all.size - window) - 1)
            html += singleLink(text, nil, false, post)
          end
        end

        html += singleLink("&rsaquo;", "disabled", curr_idx == all.size - 1, nxt)
        html += singleLink("&raquo;", "disabled", curr_idx == all.size - 1, all.last)
        
        return html
      end
      
      def singleLink(text, classIfSelected, selected, page)
        tag = "<li"
        if selected
          tag += " class=\"#{classIfSelected}\""
        end
        
        if page.nil?
          tag += "><a href=\"#\">#{text}</a>"
        else
          tag += "><a href=\"#{page.url}\">#{text}</a>"
        end
        
        tag
      end
    end
  end
end
