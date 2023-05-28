# frozen_string_literal: true
require "active_support/concern"

require "pundit_clone/version"
require "pundit_clone/authorization"

module PunditClone
  class NotAuthorizedError < StandardError; end
end
