require "yaml"

module Templates
  class Loader
    def self.load(name)
      path = Rails.root.join("config", "templates", "#{name}.yml")
      YAML.load_file(path)
    end
  end
end
