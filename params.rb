# Params
class Params
  attr_accessor :build_url
  attr_accessor :build_api_token
  attr_accessor :team_id
  attr_accessor :certificate_urls_str
  attr_accessor :passphrases_str
  attr_accessor :distribution_type
  attr_accessor :min_profile_days_valid
  attr_accessor :bundle_ids
  attr_accessor :entitlements
  attr_accessor :codesign_identity
  attr_accessor :platform_name
  attr_accessor :configuration
  attr_accessor :keychain_path
  attr_accessor :keychain_password
  attr_accessor :verbose_log

  attr_accessor :certificate_urls
  attr_accessor :passphrases

  def initialize
    @build_url = ENV['build_url']
    @build_api_token = ENV['build_api_token']
    @team_id = ENV['team_id']
    @certificate_urls_str = ENV['certificate_urls']
    @min_profile_days_valid = ENV['min_profile_days_valid'].to_i
    @passphrases_str = ENV['passphrases']
    @distribution_type = ENV['distribution_type']
    @bundle_ids = ENV['bundle_ids'].split(',')
    @entitlements = ENV['entitlements'].split(',')
    @codesign_identity = ENV['codesign_identity']
    @platform_name = ENV['platform_name']
    @keychain_path = ENV['keychain_path']
    @keychain_password = ENV['keychain_password']
    @verbose_log = ENV['verbose_log']

    @certificate_urls = split_pipe_separated_list(@certificate_urls_str)
    @passphrases = split_pipe_separated_list(@passphrases_str)
  end

  def print
    Log.info('Params:')
    Log.print("team_id: #{@team_id}")
    Log.print("certificate_urls: #{Log.secure_value(@certificate_urls_str)}")
    Log.print("min_profile_days_valid: #{@min_profile_days_valid}")
    Log.print("passphrases: #{Log.secure_value(@passphrases_str)}")
    Log.print("distribution_type: #{@distribution_type}")
    Log.print("bundle_ids: #{@bundle_ids}")
    Log.print("entitlements: #{@entitlements}")
    Log.print("codesign_identity: #{@codesign_identity}")
    Log.print("platform_name: #{@platform_name}")
    Log.print("build_url: #{@build_url}")
    Log.print("build_api_token: #{Log.secure_value(@build_api_token)}")
    Log.print("keychain_path: #{@keychain_path}")
    Log.print("keychain_password: #{Log.secure_value(@keychain_password)}")
    Log.print("verbose_log: #{@verbose_log}")
  end

  def validate
    raise 'missing: build_url' if @build_url.to_s.empty?
    raise 'missing: build_api_token' if @build_api_token.to_s.empty?
    raise 'missing: certificate_urls' if @certificate_urls_str.to_s.empty?
    raise 'missing: distribution_type' if @distribution_type.to_s.empty?
    raise 'missing: bundle_ids' if @bundle_ids.to_s.empty?
    raise 'missing: entitlements' if @entitlements.to_s.empty?
    raise 'missing: codesign_identity' if @codesign_identity.to_s.empty?
    raise 'missing: platform_name' if @platform_name.to_s.empty?
    raise 'missing: keychain_path' if @keychain_path.to_s.empty?
    raise 'missing: keychain_password' if @keychain_password.to_s.empty?
    raise 'missing: verbose_log' if @verbose_log.to_s.empty?
  end

  private

  def split_pipe_separated_list(list)
    return [''] if list.to_s.empty?
    list.split('|', -1)
  end
end
