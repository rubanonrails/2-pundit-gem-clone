# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "pundit_clone"

require "active_record"
require "minitest/autorun"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Migration.suppress_messages do
  ActiveRecord::Schema.define do
    create_table :users do |t|
      t.string :role, default: "reader"
    end

    create_table :articles do |t|
      t.string :title
      t.string :status, default: "draft"
    end
  end
end

class User < ActiveRecord::Base
  enum role: %w[reader admin].index_by(&:itself)

  validates :role, inclusion: { in: roles.values }
end

class Article < ActiveRecord::Base
  enum status: %w[draft published].index_by(&:itself)

  validates :title, presence: true
  validates :status, inclusion: { in: statuses.values }
end
