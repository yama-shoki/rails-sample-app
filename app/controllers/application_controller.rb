class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    # すでにログインしているユーザーのリダイレクト
    def already_logged_in
      if logged_in?
        redirect_to root_url, status: :see_other
      end
    end
end
