module PunditClone
  module Authorization
    extend ActiveSupport::Concern

    included do
      helper_method :policy
    end

    def policy_scope(klass)
      policy_scope_klass(klass).new(current_user, klass).resolve
    end

    def authorize(record)
      policy(record).send("#{action_name}?") or raise NotAuthorizedError
    end

    def policy(record)
      policy_klass(record).new(current_user, record)
    end

    private

    def policy_klass(record)
      "#{record.class}Policy".constantize
    end

    def policy_scope_klass(klass)
      "#{klass}Policy::Scope".constantize
    end
  end
end
