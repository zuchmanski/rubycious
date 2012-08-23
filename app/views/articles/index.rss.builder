xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Rubycious.com"
    xml.description "Hacker News just for rubyists."
    xml.link root_url

    for article in @articles
      xml.item do
        xml.title article.title
        xml.description article.body
        xml.pubDate article.updated_at.to_s(:rfc822)
        xml.link article.url
        xml.guid article.url
      end
    end
  end
end