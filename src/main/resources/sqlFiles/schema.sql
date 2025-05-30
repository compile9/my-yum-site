CREATE TABLE IF NOT EXISTS recipes (
  id SERIAL PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  description VARCHAR(300),
  rating NUMERIC(3,2) CHECK (rating >= 0.0 AND rating <= 5.0),
  image TEXT,
  duration INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS recipes_instructions (
  id SERIAL PRIMARY KEY,
  recipe_id INT NOT NULL REFERENCES recipes(id),
  instruction TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS ingredients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  category_id INT NOT NULL REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS recipes_ingredients (
  recipe_id INT NOT NULL REFERENCES recipes(id),
  ingredient_id INT NOT NULL REFERENCES ingredients(id),
  PRIMARY KEY (recipe_id, ingredient_id)
);

CREATE TABLE IF NOT EXISTS types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  type_id INT NOT NULL REFERENCES types(id)
);

CREATE TABLE IF NOT EXISTS recipes_tags (
  recipe_id INT NOT NULL REFERENCES recipes(id),
  tag_id INT NOT NULL REFERENCES tags(id),
  PRIMARY KEY (recipe_id, tag_id)
);

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(30) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  profile_picture TEXT
);

CREATE TABLE IF NOT EXISTS user_progress (
  user_id INT REFERENCES users(id),
  step_id INT REFERENCES recipes_instructions(id),
  status BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (user_id, step_id)
);

CREATE TABLE IF NOT EXISTS reviews (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(id),
  recipe_id INT NOT NULL REFERENCES recipes(id),
  rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  review_text VARCHAR(150)
);