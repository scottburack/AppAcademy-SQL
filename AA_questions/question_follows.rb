require_relative 'questions_database.rb'

class QuestionFollows
  attr_accessor :follower_id, :question_id
  
  def initialize(options)
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end
  
  def self.find_by_id(id)
    follower = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows 
      WHERE 
        id = ?
    SQL
    return nil unless follower.length > 0 
    
    QuestionFollows.new(follower.first)
  end
  
  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
       question_follows
       JOIN 
        users
        ON question_follows.follower_id = users.id
      WHERE
      question_id = ?
    SQL
    
    followers.map {|follower| User.new(follower)}

  end
  
  def self.followed_questions_for_user_id(follower_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, follower_id)
      SELECT
        questions.*
      FROM
       questions
       JOIN 
        question_follows
        ON question_follows.question_id = questions.id
        JOIN 
          users 
          ON users.id = question_follows.follower_id
      WHERE
      follower_id = ?
    SQL
    
    followers.map {|follower| Question.new(follower)}
  end
  
  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT 
        COUNT(follower_id), questions.*
      FROM
        questions 
        JOIN 
          question_follows
          ON question_follows.question_id = questions.id
          GROUP BY follower_id;
    SQL
    questions.map {|question| Question.new(question)}.take(n)
  end
  
  
end