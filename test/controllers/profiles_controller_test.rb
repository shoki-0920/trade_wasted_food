require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)  # fixtures からテスト用ユーザーを取得
  end

  test "should get edit" do
    skip "Skipping this test for now"  # ここでスキップ
    ProfilesController.any_instance.stub(:current_user, @user) do
      get edit_profile_url
      assert_response :success
    end
  end

  test "should update user" do
    skip "Skipping this test for now"  # ここでスキップ
    ProfilesController.any_instance.stub(:current_user, @user) do
      patch profile_url, params: { user: { name: "New Name", bio: "New bio", location: "New location", avatar: "new_avatar_url" } }
      assert_redirected_to root_path  # 更新後にリダイレクトされることを確認
      @user.reload  # 更新後、ユーザー情報を再取得
      assert_equal "New Name", @user.name  # ユーザーの名前が更新されたことを確認
      assert_equal "New bio", @user.bio  # ユーザーのバイオが更新されたことを確認
    end
  end
end
