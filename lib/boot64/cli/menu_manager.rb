module Boot64
    module CLI
        class MenuManager

            attr_accessor :runner,
                          :prompt,
                          :putser,
                          :file_manager,
                          :current_menu_data

            MENU_HOME_NAME = 'home'.freeze
            MENU_GENERATE_SINGLE_NAME = 'generate_single'.freeze
            MENU_GENERATE_BULK_NAME = 'generate_bulk'.freeze
            MENU_ABOUT_NAME = 'about'.freeze

            def initialize(runner)
                self.runner = runner
                self.putser = Boot64::CLI::Putser.new
                self.prompt = TTY::Prompt.new(active_color: self.putser.get_detached_highlight_color)
                self.file_manager = Boot64::CLI::FileManager.new
                self.current_menu_data = {
                    current_menu_name: MENU_HOME_NAME,
                    previous_menu_name: nil,
                    selected_modele: nil
                }
                run_menu(MENU_HOME_NAME)
            end

            private

            def run_menu(name)
                self.current_menu_data[:previous_menu_name] = self.current_menu_data[:current_menu_name]
                self.current_menu_data[:current_menu_name] = name
                self.putser.clear_terminal
                self.putser.puts_logo
                case name
                when MENU_HOME_NAME
                    definition = get_home_definition
                when MENU_GENERATE_SINGLE_NAME
                    definition =get_generate_single_definition
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

            def go_back
                run_menu(self.current_menu_data[:previous_menu_name])
            end

            def leave
                self.putser.clear_terminal
                return
            end

            def get_go_back_option
                {
                    label: 'Retour',
                    action: -> () { go_back }
                }
            end

            def get_home_definition
                {
                    behaviour: :action_on_select,
                    title: 'Menu principal',
                    options: [
                        {
                            label: 'Génération par modèle',
                            action: -> () { run_menu(MENU_GENERATE_SINGLE_NAME) }
                        },
                        {
                            label: 'Génération de masse',
                            action: -> () { run_menu(MENU_GENERATE_BULK_NAME) }
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

            def get_generate_single_definition
                options = [get_go_back_option]
                all_modeles = [] # TODO
                all_modeles.each do |modele|
                    # TODO push in options
                end
                {
                    behaviour: :action_on_select,
                    title: 'Test !',
                    options: options
                }
            end

            def get_about_definition
                {
                    on_mounted: -> () { self.putser.puts_about_text },
                    behaviour: :action_on_select,
                    title: '',
                    options: [get_go_back_option]
                }
            end

        end
    end
end
