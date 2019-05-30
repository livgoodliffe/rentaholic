module ApplicationHelper
  def avatar_url(user)
    if user.photo.present?
      user.photo
    else
      image_path 'https://scholars.seo-usa.org/wp-content/uploads/sites/3/2019/03/asl-interpreter-profiles-1-300x300.png'
    end
  end
end
