# encoding: utf-8
# author: Boris Barroso
# email: boriscyber@gmail.com
class Transaction < ActiveRecord::Base
  ########################################
  # Relationships
  belongs_to :income, foreign_key: :account_id, conditions: {type: 'Income'}
  belongs_to :expense, foreign_key: :account_id, conditions: {type: 'Expense'}
  # Users
  belongs_to :creator, class_name: 'User'
  belongs_to :approver, class_name: 'User'
  belongs_to :nuller, class_name: 'User'

  def self.transaction_columns
    self.column_names.reject {|k| %w(id account_id created_at updated_at).include? k }.map(&:to_sym)
  end
end
