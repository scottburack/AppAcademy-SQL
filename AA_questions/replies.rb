require_relative 'questions_database.rb'

class Reply
  attr_accessor :body, :user_id, :reply_id, :question_id
  attr_reader :id
  
  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @reply_id = options['reply_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
  reply = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE 
      id = ?
  SQL
    return nil unless reply.length > 0 

    Reply.new(reply.first)
  end
  
  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE 
        user_id = ?
    SQL
    
    return nil unless reply.length > 0 

    Reply.new(reply.first)
  end
  
  def self.find_by_question_id(question_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE 
        question_id = ?
    SQL
      return nil unless reply.length > 0 

      reply.map {|rep| Reply.new(rep)}
  end
  
  def self.find_by_reply_id(reply_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, reply_id)
      SELECT
        *
      FROM
        replies
      WHERE 
        reply_id = ?
    SQL
    
    return nil unless reply.length > 0 

    Reply.new(reply.first)
  end
  
  def author 
    author = User.find_by_id(user_id)
  end 
  
  def question 
    question = Question.find_by_id(question_id)
  end 
  
  def parent_reply
    parent = Reply.find_by_id(reply_id)
  end 
  
  def child_replies
    children = Reply.find_by_reply_id(id)
  end 
  
end