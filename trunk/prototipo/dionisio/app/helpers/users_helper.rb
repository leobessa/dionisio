module UsersHelper
  def avatar_for(user)                            
    md5 = Digest::MD5.hexdigest(user.email)
    img_src = "http://www.gravatar.com/avatar/#{md5}?d=wavatar"
    image_tag(img_src, :size => "80x80")
  end
end
