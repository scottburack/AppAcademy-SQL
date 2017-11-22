require 'sqlite3'
require 'singleton'
require_relative 'questions.rb'
require_relative 'replies.rb'
require_relative 'user.rb'
require_relative 'question_follows.rb'
require_relative 'question_likes.rb'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  
  def initialize()
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true

  end
end