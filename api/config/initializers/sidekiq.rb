require 'dotenv'
Dotenv.load
require 'sidekiq'
require 'sidekiq-cron'
require 'yaml'
require_relative '../../jobs/set_costumer_id_job'
require_relative '../database'

schedule_file = './schedule.yml'

if File.exist?(schedule_file)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
