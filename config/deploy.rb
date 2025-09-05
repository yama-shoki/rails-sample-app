# config valid for current version and patch releases of Capistrano
lock "~> 3.19.0"

set :application, "sample_app"
set :repo_url, "git@github.com:yama-shoki/rails-sample-app.git"
# set :rbenv_ruby, File.read('.ruby-version').strip  ← コメントアウト済み
set :branch, ENV['BRANCH'] || "main"

# rbenvを無効化してシステムRubyを使用
# set :rbenv_type, :system
# set :rbenv_ruby, 'system'

# Nginxの設定ファイル名と置き場所を修正
set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "node_modules"
