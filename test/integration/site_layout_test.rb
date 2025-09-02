require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links for non-logged-in users" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2  # logo + home link
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    
    # ログイン済みユーザー専用リンクは表示されない
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "layout links for logged-in users" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2  # logo + home link
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    
    # 未ログインユーザー専用リンクは表示されない
    assert_select "a[href=?]", login_path, count: 0
  end

  test "header navigation for non-logged-in users" do
    get root_path
    
    # Home linkをテスト
    get help_path
    assert_template 'static_pages/help'
    
    # Login linkをテスト
    get login_path
    assert_template 'sessions/new'
  end

  test "header navigation for logged-in users" do
    log_in_as(@user)
    
    # Users linkをテスト
    get users_path
    assert_template 'users/index'
    
    # Profile linkをテスト (ドロップダウンメニュー内)
    get user_path(@user)
    assert_template 'users/show'
    
    # Settings linkをテスト (ドロップダウンメニュー内)
    get edit_user_path(@user)
    assert_template 'users/edit'
  end

  test "logo link functionality" do
    get help_path
    # ロゴをクリックしてホームに戻る
    get root_path
    assert_template 'static_pages/home'
  end
end