module PostsHelper
  def post_reserve
    if @post.reserve(:reserve, "0")
      "予約済み"
    end
  end
  
  def to_minit(time)
    time_ary = time.to_s(:time).split(":").map(&:to_i)
    time_ary[0] * 60 + time_ary[1]
  end
end