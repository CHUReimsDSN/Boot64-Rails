module Boot64
    module CLI
        class MenuManager

            attr_accessor :prompt
                        
            MENU_HOME_NAME = 'home'.freeze
            MENU_GENERATE_NAME = 'generate'.freeze

            def initialize(prompt)
                self.prompt = prompt
                run_menu(MENU_HOME_NAME)
            end

            private
            def run_menu(name)
                definition = get_menu_definition(name)
                response = prompt.select(definition[:title], definition[:options].map {|option| option[:label]})
                puts response
                puts response.class
                case definition[:behaviour]
                when :action_on_select
                    option_found = definition[:options].find do |option| 
                        puts "!!!!"
                        puts option
                        option[:label] == response
                    end
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
                else
                    get_home_definition
                end
            end

            def get_home_definition
                {
                    behaviour: :action_on_select,
                    title: 'Bienvenue dans Boot64 !',
                    options: [
                        {
                            label: 'Génération fichier TypeScript',
                            action: -> () { run_menu(MENU_GENERATE_NAME) }
                        },
                        {
                            label: 'A propos',
                            action: -> () { run_menu(MENU_GENERATE_NAME) }
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

        end
    end
end
