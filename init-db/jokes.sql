create table if not exists jokes
(
  id serial primary key,
  title varchar (150) NOT NULL,
  author varchar (50) NOT NULL,
  jokeText text,
  date_added date DEFAULT CURRENT_TIMESTAMP
);
