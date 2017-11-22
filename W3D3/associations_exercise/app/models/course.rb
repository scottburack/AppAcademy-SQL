class Course < ApplicationRecord
  
  has_many :enrollments,
  class_name: "Enrollment",
  foreign_key: :course_id,
  primary_key: :id
  
  has_many :users,
  through: :enrollments,
  source: :student
  
  belongs_to :pre_req,
  class_name: 'Course',
  foreign_key: :prereq_id,
  primary_key: :id
  
  has_many :post_reqs,
  class_name: 'Course',
  foreign_key: :prereq_id,
  primary_key: :id
  
  belongs_to :instructor,
  class_name: "User",
  foreign_key: :instructor_id,
  primary_key: :id
  
  
end
