module Jekyll
  # This plugin will make Perplexity generated sources section to use `details` and `summary` tag
  # So it won't take so much space in our post
  class SourcesRewriter < Generator
    safe true
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        post.content = rewrite_sources(post.content)
      end
    end

    private

    def rewrite_sources(content)
      # Split content by the Sources marker
      parts = content.split(/---\n\*\*Sources:\*\*/)

      # Return original content if no sources found
      return content if parts.length <= 1

      # Process each section except the first (which is content before first Sources)
      result = parts[0].dup
      parts[1..-1].each do |part|
        # Split the part into sources and remaining content
        section_parts = part.split(/---|\n##/)
        sources = section_parts[0]

        # Format the sources section
        sources_html = "<details>\n  <summary>Sources:</summary>\n\n<ol>"
        sources.strip.split("\n- ").each do |source|
          next if source.strip.empty?

          if source.strip =~ /\[\(([\d]+)\)\s+([^\]]+)\]\(([^\)]+)\)/
            _number = $1
            title = $2
            url = $3
            sources_html += "<li><a href=\"#{url}\">#{title}</a></li>\n"
          else
            sources_html += "<li> #{source.strip}</li>\n"
          end
        end
        sources_html += "</ol></details>"

        # Add the processed sources and any remaining content
        result += sources_html
        result += "\n\n##" + section_parts[1..-1].join("\n##") if section_parts.length > 1
      end

      result
    end
  end
end

