require_relative 'questions_database.rb'

class QuestionLikes
  attr_accessor :user_id, :question_id
  
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
  likes = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE 
      id = ?
  SQL
  return nil unless likes.length > 0 

  QuestionLikes.new(likes.first)
  end

end