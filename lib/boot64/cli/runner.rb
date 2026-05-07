require "tty-prompt"

class Boot64::Cli::Runner

    attr_accessor :prompt,
                  :menu_manager,

    def self.boot
        instance = self.new
        instance.launch
    end

    private
    def initialize
        self.prompt = TTY::Prompt.new
        self.menu_manager = Boot64::Cli::MenuManager.new
    end

    def launch

    end

end