DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (follower_id) REFERENCES users(id) 
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  reply_id INTEGER,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES questions(user_id),
  FOREIGN KEY (reply_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id), 
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
  users (id, fname, lname)
VALUES  
  (1, 'Scott', 'Burack'),
  (2, 'Dae', 'Kim'),
  (3, 'Luke', 'Espina'),
  (4, 'Kati', 'Townlit'),
  (5, 'Tommy', 'Duek');

INSERT INTO
  questions (id, title, body, user_id)
VALUES  
  (1, 'SQLite3', 'What is SQLite3?', 3),
  (2, 'Assessment 3', 'What is going to be on A03?', 1);

  
INSERT INTO
  question_follows (id, follower_id, question_id)
VALUES  
  (1, 2, 1),
  (2, 4, 2);

INSERT INTO
  replies (id, body, user_id, reply_id, question_id)
VALUES  
  (1, 'It is a RDBMS.', 1, NULL, 1),
  (2, 'SQL and Rails.', 5, NULL, 2),
  (3, 'That''s right!', 5, 1, 1);

INSERT INTO
  question_likes (id, user_id, question_id)
VALUES 
  (1, 2, 1),
  (2, 3, 2);