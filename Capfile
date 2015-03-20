# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# rbenvを使用している場合
require 'capistrano/rbenv'

require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

require 'capistrano/bundler'
require 'capistrano3/unicorn' # unicornを使っている場合のみ

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
