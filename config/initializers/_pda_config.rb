# Be sure to restart your server when you modify this file.
module PDA
  def config
    @config ||= config_yaml.with_indifferent_access
  end

  private

  def config_yaml
    load_yaml File.read(Rails.root.join('config', 'secrets', 'pda_config.yml'))
  rescue Errno::ENOENT
    load_yaml File.read(Rails.root.join('config', 'pda_config_example.yml'))
  end

  def load_yaml(str)
    YAML.safe_load(ERB.new(str).result, [Symbol], [], true)[Rails.env]
  end

  module_function :config, :config_yaml, :load_yaml
end
