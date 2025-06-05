crumb :root do
  link "Home", root_path
end

crumb :posts do
  link "投稿一覧", posts_path
  parent :root   # 親は :root（Home）
end

crumb :post do |post|
  link post.title, post_path(post)
  parent :posts  # 親は :posts（投稿一覧）
end

crumb :new_post do
  link "新規投稿", new_post_path
  parent :posts
end

crumb :edit_post do |post|
  link "#{post.title}を編集", edit_post_path(post)
  parent :post, post
end

crumb :edit_profile do |user|
  link "プロフィール編集", edit_profile_path(user)
  parent :posts
end

crumb :fishing_spots_map do
  link "釣りスポット一覧", fishing_spots_map_path
  parent :posts
end


crumb :chatrooms do
  link "チャットルーム一覧", chat_rooms_path
  parent :posts
end

crumb :chatroom do |chatroom, current_user|
  # 1) モデルの other_user メソッドを使って相手ユーザーを取得
  other = chatroom.other_user(current_user)

  # 2) 相手ユーザーが取れたら「◯◯さんとのチャットルーム」
  #    取れなければ「チャットルーム##ID」などのフォールバック
  if other
    label = "#{other.name} さんとのチャット"
  else
    label = chatroom.name.presence || "チャットルーム##{chatroom.id}"
  end

  link label, chat_room_path(chatroom)

  # 親は「チャットルーム一覧」
  parent :chatrooms
end



# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
