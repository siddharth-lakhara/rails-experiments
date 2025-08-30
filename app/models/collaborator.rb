class Collaborator < ApplicationRecord
  PERMISSIONS = [
    "OWNER",
    "EDITOR",
    "VIEWER"
  ].freeze
end
