require "rails/command"
require "tty-prompt"

class Boot64Command < Rails::Command::Base
    desc "boot64", "Lancer boot64"
    
    def perform
        prompt = TTY::Prompt.new

        choices = prompt.multi_select(
        "Choisis :",
        %w[Auth Billing Admin]
        )

        puts choices.inspect
    end
end