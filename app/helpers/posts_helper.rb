module PostsHelper
  def tag_links(tags)
    tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(" ")
  end

  def self.tagged_posts(name)
    Tag.find_by_name!(name).posts
  end

end
