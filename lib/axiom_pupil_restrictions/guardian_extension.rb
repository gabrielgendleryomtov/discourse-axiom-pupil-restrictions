# frozen_string_literal: true

module ::AxiomPupilRestrictions
  module GuardianExtension
    def can_edit_username?(target_user)
      return super if user&.staff?
      return false if ::AxiomPupilRestrictions.restricted_pupil?(target_user)

      super
    end

    def can_edit_name?(target_user)
      return super if user&.staff?
      return false if ::AxiomPupilRestrictions.restricted_pupil?(target_user)

      super
    end
  end
end
