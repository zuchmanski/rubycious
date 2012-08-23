config = File.read(Rails.root.join("config", "config.yml"))
APP_CONFIG = YAML.load(config)[Rails.env.to_s]
