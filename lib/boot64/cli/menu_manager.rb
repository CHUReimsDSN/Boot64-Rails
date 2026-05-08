module Boot64
    module CLI
        class MenuManager

            attr_accessor :runner,
                          :prompt,
                          :putser

            MENU_HOME_NAME = 'home'.freeze
            MENU_GENERATE_NAME = 'generate'.freeze
            MENU_ABOUT_NAME = 'about'.freeze

            def initialize(runner)
                self.runner = runner
                self.putser = Boot64::CLI::Putser.new
                self.prompt = TTY::Prompt.new(active_color: self.putser.get_detached_highlight_color)
                run_menu(MENU_HOME_NAME)
            end

            private

            def run_menu(name)
                self.putser.clear_terminal
                self.putser.puts_logo
                case name
                when MENU_HOME_NAME
                    definition = get_home_definition
                when MENU_GENERATE_NAME
                    definition =get_generate_definition
                when MENU_ABOUT_NAME
                    definition = get_about_definition
                else
                    raise
                end

                if definition[:on_mounted]
                    definition[:on_mounted].call
                end

                case definition[:behaviour]
                when :action_on_select
                    response = self.prompt.select(
                        self.putser.get_string_bold("#{definition[:title]} \n"),
                        definition[:options].map {|option| option[:label]},
                        show_help: :never
                    )
                    option_found = definition[:options].find {|option| option[:label] == response}
                    if option_found.nil?
                        raise
                    end
                    option_found[:action].call
                when :action_on_enter
                    
                else
                    raise
                end
            end

            def leave
                self.putser.clear_terminal
                return
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
                        },
                        {
                            label: 'Quitter',
                            action: -> () { leave }
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
                    on_mounted: -> () { self.putser.puts_about_text },
                    behaviour: :action_on_select,
                    title: '',
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
