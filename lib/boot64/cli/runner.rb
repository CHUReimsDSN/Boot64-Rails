require "tty-prompt"
require "tty-font"
require "pastel"

module Boot64
    module CLI
        class Runner

            attr_accessor :prompt,
                          :font,
                          :pastel,
                          :menu_manager

            def self.boot
                instance = self.new
            end

            private
            def initialize
                self.prompt = TTY::Prompt.new
                self.font = TTY::Font.new(:doom)
                self.pastel = Pastel.new
                self.menu_manager = Boot64::CLI::MenuManager.new(self.prompt)
            end

        end
    end
end