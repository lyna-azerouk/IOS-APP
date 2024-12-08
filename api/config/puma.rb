# config/puma.rb
port ENV.fetch("PORT") { 4567 }
environment ENV.fetch("RACK_ENV") { "development" }
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
threads_count = ENV.fetch("MAX_THREADS") { 5 }
threads threads_count, threads_count
preload_app!
