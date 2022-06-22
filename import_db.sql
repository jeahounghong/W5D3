DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user INTEGER NOT NULL,
    parent_reply INTEGER,
    body TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user) REFERENCES users(id),
    FOREIGN KEY (parent_reply) REFERENCES replies(id)
);

CREATE TABLE question_likes (   
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

--seeding database

--seeding users
INSERT INTO 
    users (fname, lname)
VALUES
    ('Calvin','Koo'),
    ('David','Hong'),
    ('Ben','Simmons');

--seeding questions
INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Questions 1','Body_1', (SELECT id FROM users WHERE fname = 'David' AND lname = 'Hong')),
    ('Questions 2', 'Body_2', (SELECT id from users WHERE fname = 'Calvin' AND lname = 'Koo')),
    ('Questions 3', 'Body_3', (SELECT id from users WHERE fname = 'Ben' AND lname = 'Simmons'));

--seeding question_follows()
INSERT INTO
    question_follows (user_id, question_id)
VALUES
    ((SELECT id from users WHERE fname = 'Calvin'), (SELECT id from questions WHERE title = 'Questions 1' ));


--seeding replies
INSERT INTO
    replies (question_id, user, parent_reply, body)
VALUES
    ((SELECT id FROM questions WHERE title = 'Questions 1'), 1, NULL, 'Good question'),
    ((SELECT id FROM questions WHERE title = 'Questions 1'), 1, (SELECT id FROM replies WHERE body = 'Good question'), 'Good reply'),
    ((SELECT id FROM questions WHERE title = 'Questions 1'), 2, NULL, 'Second Parent Reply');


--seeing question likes
INSERT INTO
    question_likes (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "David"), (SELECT id FROM questions WHERE title = 'Questions 1'));
    

















