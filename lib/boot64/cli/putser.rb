module Boot64
    module CLI
        class Putser

            attr_accessor :pastel,
                          :font

            HIGHLIGHT_COLOR = :yellow.freeze

            def initialize
                self.font = TTY::Font.new(:doom)
                self.pastel = Pastel.new
            end

            def get_detached_highlight_color
                self.pastel.public_send(HIGHLIGHT_COLOR).detach
            end

            def clear_terminal
                if Gem.win_platform?
                    system("cls")
                else
                     system("clear")
                end
                print "\e[2J\e[H"
            end

            def get_string_highlight(message)
                self.pastel.decorate(message, HIGHLIGHT_COLOR, :bold)
            end

            def get_string_bold(message)
                self.pastel.decorate(message, :bold)

            def puts_logo
                puts self.get_string_highlight(%q{
______             _    ____    ___       ____
| ___ \           | |  / ___|  /   |     /   /
| |_/ / ___   ___ | |_/ /___  / /| |    /_  /_
| ___ \/ _ \ / _ \| __| ___ \/ /_| |     /  _/
| |_/ / (_) | (_) | |_| \_/ |\___  |    / ,'
\____/ \___/ \___/ \__\_____/    |_/   /'
                                                                       
                })
            end

            def puts_about_text
                puts ("""
#{self.get_string_highlight("Description")} : Boot64 est un CLI permettant de générer des APIs TypeScript
              en se basant sur les modèle définis dans ActiveRecord
#{self.get_string_highlight("Version")} : #{Boot64::VERSION}

                """)
            end

        end
    end
end