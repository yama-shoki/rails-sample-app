# config valid for current version and patch releases of Capistrano
lock "~> 3.19.0"
set :application, "sample_app"
set :repo_url, "git@github.com:yama-shoki/rails-sample-app.git"
set :branch, ENV['BRANCH'] || "main"

# Nginxの設定ファイル名と置き場所を修正
set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "node_modules"

# bundler設定（deploymentフラグを削除）
set :bundle_flags, '--quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_env_variables, { 'BUNDLE_IGNORE_RUBY_VERSION' => '1' }
