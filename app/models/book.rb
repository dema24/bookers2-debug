class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_many :week_favorites, -> {where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)...(Time.current.at_end_of_day)) }, class_name: 'Favorite'


  has_many :book_comments, dependent: :destroy

  has_many :view_counts, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum:200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == "perfect"
      @book = Book.where("title LIKE?", "#{content}")
    elsif method == "forword"
      @book = Book.where("name LIKE?", "%#{cotent}")
    elsif method == "backword"
      @book = Book.where("name LIKE?", "#{content}%")
    else
      @book = Book.where("title LIKE?", "%#{content}%")
    end
  end

end
