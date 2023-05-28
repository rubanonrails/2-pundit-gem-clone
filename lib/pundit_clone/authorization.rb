module PunditClone
  module Authorization
    extend ActiveSupport::Concern

    included do
      helper_method :policy if respond_to?(:helper_method)
    end

    def policy_scope(klass, user = default_user)
      policy_scope_klass(klass).new(user, klass).resolve
    end

    def authorize(record, user = default_user, query = default_query)
      policy(record, user).send(query) or raise NotAuthorizedError
    end

    def policy(record, user = default_user)
      policy_klass(record).new(user, record)
    end

    private

    def default_query
      "#{action_name}?"
    end

    def default_user
      current_user
    end

    def policy_klass(record)
      "#{record.class}Policy".constantize
    end

    def policy_scope_klass(klass)
      "#{klass}Policy::Scope".constantize
    end
  end
end
