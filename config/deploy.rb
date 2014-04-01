set :application, "values-survey"
set :deploy_to, "/home/valuessurvey/rails"
set :use_sudo, false

set :repository,  "git@github.com:jwnichls/values-survey.git"
set :branch, "study_only"

set :user, "valuessurvey"               # define the user account
set :domain, "qcrowd.com"               # define our domain
server domain, :web, :app               # define that our domain is where the app and web servers are
role :db, domain, :primary => true      # This is where Rails migrations will run

# ==============================
# Deploy
# ==============================

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
