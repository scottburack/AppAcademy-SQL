require_relative 'questions_database.rb'

class Question
  attr_accessor :title, :body, :user_id
  attr_reader :id
    
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
  
  def self.find_by_id(id)  
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions 
      WHERE 
        id = ?
    SQL
    return nil unless question.length > 0 
    
    Question.new(question.first)
  end
  
  def self.find_by_user_id(user_id)  
    question = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions 
      WHERE 
        user_id = ?
    SQL
    return nil unless question.length > 0 
    
    Question.new(question.first)
  end
  
  def author
    author = User.find_by_id(user_id)
  end 
  
  def replies 
    replies = Reply.find_by_question_id(@id)
  end 
  
  def followers 
    QuestionFollows.followers_for_question_id(id)
  end 
  
  def self.most_followed(n)
    QuestionFollows.most_followed_questions(n)
  end 
  
end