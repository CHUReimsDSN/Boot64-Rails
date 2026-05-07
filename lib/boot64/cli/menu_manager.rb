require "tty-font"

module Boot64
    module CLI
        class MenuManager

            attr_accessor :prompt,
                          :has_been_introduced
                        
            MENU_HOME_NAME = 'home'.freeze
            MENU_GENERATE_NAME = 'generate'.freeze
            MENU_ABOUT_NAME = 'about'.freeze

            def initialize(prompt)
                self.prompt = prompt
                self.has_been_introduced = false
                run_menu(MENU_HOME_NAME)
            end

            private
            def puts_intro_message
                font = TTY::Font.new(:doom)
                puts font.write('Boot64')
                self.has_been_introduced = true
            end

            def clear_terminal
                Gem.win_platform? ? system("cls") : system("clear")
                print "\e[2J\e[H"
            end

            def run_menu(name)
                if !self.has_been_introduced
                    puts_intro_message
                end
                clear_terminal
                definition = get_menu_definition(name)
                if definition[:on_mounted]
                    definition[:on_mounted].call
                end
                response = prompt.select("#{definition[:title]} \n", definition[:options].map {|option| option[:label]})
                case definition[:behaviour]
                when :action_on_select
                    option_found = definition[:options].find {|option| option[:label] == response}
                    if option_found.nil?
                        raise
                    end
                    option_found[:action].call
                else
                    raise
                end
            end

            def get_menu_definition(name)
                case name
                when MENU_HOME_NAME
                    get_home_definition
                when MENU_GENERATE_NAME
                    get_generate_definition
                when MENU_ABOUT_NAME
                    get_about_definition
                else
                    get_home_definition
                end
            end

            def get_home_definition
                {
                    behaviour: :action_on_select,
                    title: 'Menu principal',
                    options: [
                        {
                            label: 'Génération fichier TypeScript',
                            action: -> () { run_menu(MENU_GENERATE_NAME) }
                        },
                        {
                            label: 'A propos',
                            action: -> () { run_menu(MENU_ABOUT_NAME) }
                        }
                    ]
                }
            end

            def get_generate_definition
                {
                    behaviour: :action_on_select,
                    title: 'Test !',
                    options: [
                        {
                            label: 'Génération fichier TypeScript',
                            action: -> () { run_menu(MENU_GENERATE_NAME) }
                        }
                    ]
                }
            end

            def get_about_definition
                {
                    on_mounted: -> () { 
                        font = TTY::Font.new(:doom)
                        puts font.write('By Jules Debeaumont')
                        puts font.write('Version 0')
                    },
                    behaviour: :action_on_select,
                    title: 'Test !',
                    options: [
                        {
                            label: 'Retour',
                            action: -> () { run_menu(MENU_HOME_NAME) }
                        }
                    ]
                }
            end

        end
    end
end
