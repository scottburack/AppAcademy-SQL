require_relative 'questions_database.rb'

class User
  attr_accessor :fname, :lname
  attr_reader :id
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def self.find_by_id(id)
  user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE 
      id = ?
  SQL
    return nil unless user.length > 0 

    User.new(user.first)
  end
  
  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users 
      WHERE 
        fname = ? AND lname = ?

    SQL
    return nil unless user.length > 0 
    
    User.new(user.first)
  end
  
  def authored_questions
    questions = Question.find_by_user_id(@id)
    
  end 
  
  def authored_responses
    replies = Reply.find_by_user_id(@id)
  end 
  
  def followed_questions 
    QuestionFollows.followed_questions_for_user_id(id)
  end 
  
end