require "tty-prompt"

namespace :boot64 do
  desc "Launch interactive CLI"
  task run: :environment do
    Boot64::Cli::Runner.boot
  end
end
