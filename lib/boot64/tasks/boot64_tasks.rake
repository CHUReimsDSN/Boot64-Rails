namespace :boot64 do
  desc "Launch boot64 CLI"
  task run: :environment do
    Boot64::CLI::Runner.boot
  end
end
