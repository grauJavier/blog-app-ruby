class Post < ApplicationRecord
  belongs_to :author, class_name:"user", foreign_key: :author_id
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id
end
