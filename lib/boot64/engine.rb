module Boot64
    class Engine < Rails::Engine
        rake_tasks do
            load File.expand_path('./tasks/boot64_tasks.rake', __dir__)
        end
    end
end
