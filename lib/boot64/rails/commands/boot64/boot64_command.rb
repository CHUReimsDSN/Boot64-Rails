require "rails/command"
require "tty-prompt"

class Boot64Command < Rails::Command::Base
    desc "run", "Lancer boot64"

    def run
        prompt = TTY::Prompt.new

        choices = prompt.multi_select(
        "Choisis :",
        %w[Auth Billing Admin]
        )

        puts choices.inspect
    end
end