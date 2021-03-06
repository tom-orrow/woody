class Article < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :image, ImageUploader

  friendly_id :title, use: :slugged

  # Validations
  validates :title, length: { minimum: 15 }
  validates :body, length: { minimum: 15 }
  validates :slug, length: { minimum: 5 }

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def next
    article = Article.where("id > ?", id).order("id ASC").first
    if !article
      article = Article.first
    end
    article
  end

  def prev
    article = Article.where("id < ?", id).order("id DESC").first
    if !article
      article = Article.last
    end
    article
  end

  def related
    (Article.where("id > ?", id).order("id ASC") + Article.where("id < ?", id).order("id ASC"))[0..5]
  end
end
