module ApplicationHelper
  def permalink_for(post)
    sprintf("/%d/%02d/%s",
      post.created_at.year,
      post.created_at.month,
      post.slug
    )
  end
end
