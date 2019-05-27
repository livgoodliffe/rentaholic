namespace :db do
  desc 'Full Reset (Drop, Create, Migrate, Seed)'
  task :dev_reset do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end
end
