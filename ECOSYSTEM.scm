;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ECOSYSTEM.scm - Project ecosystem positioning

(ecosystem
  (version "1.0.0")
  (name "asdf-openssl-plugin")
  (type "asdf-plugin")
  (purpose "Version management for OpenSSL cryptography library")

  (position-in-ecosystem
    (category "developer-tools")
    (subcategory "version-management")
    (layer "user-facing"))

  (related-projects
    (sibling-standard
      (name "asdf")
      (relationship "plugin-host")
      (url "https://asdf-vm.com"))
    (sibling-standard
      (name "openssl")
      (relationship "managed-tool")
      (url "https://www.openssl.org/")))

  (what-this-is
    "An asdf plugin for managing OpenSSL cryptography library versions")

  (what-this-is-not
    "Not a standalone version manager"
    "Not a replacement for the tool itself"))
