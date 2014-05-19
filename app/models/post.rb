class Post < ActiveRecord::Base
  extend FriendlyId

  belongs_to :author, class_name: 'User'
  belongs_to :category

  friendly_id :title, use: :slugged

  def self.paginated_list(page)
    self.paginate(:page => page || 1, :per_page => 7).order('created_at DESC')
  end

  # will_paginate
  self.per_page = 10
end
