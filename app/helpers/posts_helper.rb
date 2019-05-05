module PostsHelper
  def post_reserve
    if @post.reserve(:reserve, "0")
      "予約済み"
    end
  end
end