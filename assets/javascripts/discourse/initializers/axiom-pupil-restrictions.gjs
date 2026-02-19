import { withPluginApi } from "discourse/lib/plugin-api";

const PUPIL_BODY_CLASS = "axiom-pupil-restrictions-pupil";

/**
 * Parse a pipe-delimited group-list site setting into unique numeric IDs.
 *
 * @param {string} rawSetting
 * @returns {number[]}
 */
function parseGroupIds(rawSetting) {
  return (rawSetting || "")
    .split("|")
    .map((id) => Number(id))
    .filter(
      (id, index, ids) =>
        Number.isInteger(id) && id > 0 && ids.indexOf(id) === index
    );
}

/**
 * Extract numeric group IDs from the current user model.
 *
 * @param {object} currentUser
 * @returns {number[]}
 */
function currentUserGroupIds(currentUser) {
  return (currentUser?.groups || [])
    .map((group) => Number(group?.id))
    .filter(
      (id, index, ids) =>
        Number.isInteger(id) && id > 0 && ids.indexOf(id) === index
    );
}

/**
 * Return true when the current user is in any configured pupil group.
 *
 * @param {object} currentUser
 * @param {object} siteSettings
 * @returns {boolean}
 */
function isCurrentUserPupil(currentUser, siteSettings) {
  const pupilGroupIds = parseGroupIds(
    siteSettings?.axiom_pupil_restrictions_pupil_groups
  );

  if (!pupilGroupIds.length) {
    return false;
  }

  const userGroupIds = currentUserGroupIds(currentUser);
  return userGroupIds.some((id) => pupilGroupIds.includes(id));
}

export default {
  name: "axiom-pupil-restrictions",

  /**
   * Add a deterministic body class for pupil users so CSS can hide restricted
   * account fields without relying on fragile upstream class names.
   *
   * @param {object} owner
   */
  initialize(owner) {
    withPluginApi(() => {
      const siteSettings = owner.lookup("service:site-settings");
      const currentUser = owner.lookup("service:current-user");

      const pluginEnabled = !!siteSettings?.axiom_pupil_restrictions_enabled;
      const pupil =
        !!currentUser &&
        pluginEnabled &&
        isCurrentUserPupil(currentUser, siteSettings);

      if (pupil) {
        document.body.classList.add(PUPIL_BODY_CLASS);
      } else {
        document.body.classList.remove(PUPIL_BODY_CLASS);
      }
    });
  },
};
