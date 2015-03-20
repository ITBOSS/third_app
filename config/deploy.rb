# coding: utf-8
# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'third_app'
set :repo_url, 'git@github.com:ITBOSS/third_app.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/vagrant/workspace/third_app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

#rbenvをシステムにインストールしたか? or ユーザーローカルにインストールしたか?
set :rbenv_type, :user # :system or :user
# rubyのversion
set :rbenv_ruby, '2.1.4'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# Default value for keep_releases is 5
set :keep_releases, 5

# bundle installの並列実行数
set :bundle_jobs, 4


namespace :deploy do

  # 上記linked_filesで使用するファイルをアップロードするタスク
  desc 'Upload database.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

#  after :publishing, :restart
#
#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      # Here we can do anything such as:
#      # within release_path do
#      #   execute :rake, 'cache:clear'
#      # end
#    end
#  end

end

# linked_filesで使用するファイルをアップロードするタスクは、deployが行われる前に実行する必要がある
before 'deploy:starting', 'deploy:upload'
# Capistrano 3.1.0 からデフォルトで deploy:restart タスクが呼ばれなくなったので、ここに以下の1行を書く必要がある
after 'deploy:publishing', 'deploy:restart'
