require 'dotenv'
Dotenv.load
require 'sidekiq'
require 'sidekiq-cron'
require 'yaml'
require_relative '../database'
require_relative '../../jobs/set_costumer_id_job'
require_relative '../../jobs/dwolla/customer_activated_job'
require_relative '../../jobs/dwolla/customer_desactivated_job'
require_relative '../../jobs/dwolla/customer_suspended_job'

schedule_file = './schedule.yml'

if File.exist?(schedule_file)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
