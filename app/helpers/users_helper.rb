module UsersHelper

    # 渡されたユーザーのGravatar画像を返す
    def gravatar_for(user, options = { size: size })
      gravatar_id = Digest::MD5::hexdigest(user.user_name.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.user_name, class: "gravatar")
    end
  
end
