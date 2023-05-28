require "test_helper"

class ArticlePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    user.admin? || record.published?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.admin? ? scope.all : scope.published
    end
  end
end

class TestPunditCloneAuthorization < Minitest::Test
  include PunditClone::Authorization

  def setup
    @reader = User.create! role: :reader
    @admin  = User.create! role: :admin

    @draft_article     = Article.create! title: "Draft",     status: :draft
    @published_article = Article.create! title: "Published", status: :published
  end

  def test_policy
    assert_kind_of ArticlePolicy,  policy(@draft_article, @reader)

    assert_equal   @reader,        policy(@draft_article, @reader).user
    assert_equal   @draft_article, policy(@draft_article, @reader).record
  end

  def test_authorize
    assert_raises PunditClone::NotAuthorizedError do
      authorize(@draft_article, @reader, :show?)
    end

    assert authorize(@draft_article, @admin, :show?)
    assert authorize(@published_article, @reader, :show?)
  end

  def test_policy_scope
    assert_equal Article.published, policy_scope(Article, @reader)
    assert_equal Article.all,       policy_scope(Article, @admin)
  end
end
