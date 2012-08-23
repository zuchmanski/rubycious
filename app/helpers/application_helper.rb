module ApplicationHelper

  def formatted_tags(body)
    body.scan(Article::TAGS_REGEXP).each do |tag|
      body.gsub!(tag, link_to(tag, tagged_path(tag[1..-1].downcase), :class => 'tag'))
    end

    body.html_safe
  end
end