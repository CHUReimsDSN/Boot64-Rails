require "tty-prompt"
require "tty-font"
require "pastel"

module Boot64
    module CLI
        class Runner

            attr_accessor :menu_manager

            def self.boot
                instance = self.new
            end

            private
            def initialize
                self.menu_manager = Boot64::CLI::MenuManager.new(self)
            end

        end
    end
end