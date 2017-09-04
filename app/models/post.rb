class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 140}
  validates :body, presence: true
  has_many :post_tags
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :tags

  def all_tags=(names)
  self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
  end
end

def all_tags
  self.tags.map(&:name).join(", ")
end
end
