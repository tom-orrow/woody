module ApplicationHelper
  def truncate_article_title(article)
    raw(truncate(strip_tags(article.body), length: 210, omission: "#{link_to '...', article_path(article)}", escape: false))
  end
end
