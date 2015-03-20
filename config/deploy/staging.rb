# coding: utf-8
set :stage, :staging
set :rails_env, "staging"
set :unicorn_rack_env, "staging"

# この設定がないと、デプロイ先でdb:migrateされない
set :migration_role, 'db'

role :app, %w{root@192.168.33.12}
role :web, %w{root@192.168.33.12}
role :db,  %w{root@192.168.33.12}

server '192.168.33.12', user: 'root', roles: %w{web app db}

set :ssh_options, {
     keys: [File.expand_path('/root/.ssh/id_rsa')],
     forward_agent: true,
     #auth_methods: %w(publickey)
     auth_methods: %w(password),
     password: 'vagrant'
}
