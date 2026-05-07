module Boot64
    module CLI
        class MenuManager

            attr_accessor :prompt
                        
            MENU_HOME_NAME = 'home'.freeze
            MENU_GENERATE_NAME = 'generate'.freeze

            def initialize(prompt)
                self.prompt = prompt
                set_current_menu(MENU_HOME_NAME)
            end

            def set_current_menu(name)
                definition = get_menu_definition(name)
                response = prompt.select(definition[:title], definition[:options].map {|option| option[:label]})
                puts response
            end

            private
            def get_menu_definition(name)
                case name
                when MENU_HOME_NAME
                    get_home_definition
                else
                    get_home_definition
                end
            end

            def get_home_definition
                {
                    title: 'Bienvenue dans Boot64 !',
                    options: [
                        {
                            label: 'Génération fichier TypeScript',
                            action: -> () { set_current_menu(MENU_GENERATE_NAME) }
                        }
                    ]
                }
            end

        end
    end
end
