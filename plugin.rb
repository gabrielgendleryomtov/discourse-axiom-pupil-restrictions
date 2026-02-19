# frozen_string_literal: true

# name: axiom-pupil-restrictions
# about: Restricts specific pupil account-edit privileges
# version: 0.1
# authors: Axiom Maths / Gabriel Gendler Yom-Tov
# url: https://axiommaths.com

enabled_site_setting :axiom_pupil_restrictions_enabled

register_asset "stylesheets/common/hide-name-and-username-for-pupils.scss"

after_initialize do
  next unless SiteSetting.axiom_pupil_restrictions_enabled

  require_relative "lib/axiom_pupil_restrictions/common"
  require_relative "lib/axiom_pupil_restrictions/guardian_extension"

  ::Guardian.prepend(::AxiomPupilRestrictions::GuardianExtension)
end
