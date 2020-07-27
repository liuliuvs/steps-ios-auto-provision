require 'xcodeproj'
require 'json'
require 'plist'
require 'English'

# ProjectHelper ...
class ProjectHelper
  attr_reader :project_codesign_identity
  attr_reader :project_team_id
  attr_reader :targets
  attr_reader :platform

  def initialize(bundle_ids, entitlements, team_id, codesign_identity, platform_name)
    @project_codesign_identity = codesign_identity
    @entitlements = entitlements
    @project_team_id = team_id
    @platform = platform_name
    @targets = bundle_ids
  end

  def uses_xcode_auto_codesigning?
    false
  end

  def target_bundle_id(target_name)
    target_name
  end

  def target_entitlements(target_name)
    index = @targets.index(target_name)
    if index != nil && index < @entitlements.length
      entitlements = @entitlements[index]
      if entitlements != nil && entitlements.length == 0
          return nil
      else
        return entitlements
      end
    end
    return nil
  end

  def force_code_sign_properties(target_name, development_team, code_sign_identity, provisioning_profile_uuid)
  end
end
