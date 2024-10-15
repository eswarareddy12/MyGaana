CREATE DATABASE MyGaana;

CREATE TABLE artist (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE album (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT,
    title VARCHAR(100) NOT NULL,
    release_year INT,
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id) ON DELETE CASCADE
);

CREATE TABLE track (
    track_id INT AUTO_INCREMENT PRIMARY KEY,
    album_id INT,
    title VARCHAR(100) NOT NULL,
    duration INT, -- in seconds
    genre VARCHAR(50),
    FOREIGN KEY (album_id) REFERENCES album(album_id) ON DELETE CASCADE
);

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    subscription_type ENUM('free', 'premium') NOT NULL,
    country VARCHAR(50)
);

CREATE TABLE play_history (
    play_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    track_id INT,
    play_date DATETIME,
    duration_played INT, -- in seconds
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES track(track_id) ON DELETE CASCADE
);

CREATE TABLE playlist (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100),
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);


CREATE TABLE playlist_track (
    playlist_track_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_id INT,
    track_id INT,
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES track(track_id) ON DELETE CASCADE
);

CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- Insert sample data into artist table
INSERT INTO artist (name, genre, country) 
VALUES 
('Taylor Swift', 'Pop', 'USA'),
('Arijit Singh', 'Bollywood', 'India'),
('Ed Sheeran', 'Pop', 'UK'),
('Beyonce', 'R&B', 'USA'),
('The Weeknd', 'R&B', 'Canada'),
('Badshah', 'Hip-Hop', 'India'),
('Billie Eilish', 'Alternative', 'USA'),
('Coldplay', 'Rock', 'UK'),
('Adele', 'Pop', 'UK'),
('Post Malone', 'Hip-Hop', 'USA');

-- Insert sample data into album table
INSERT INTO album (artist_id, title, release_year)
VALUES
(1, '1989', 2014),
(2, 'Tum Hi Ho', 2013),
(3, 'Divide', 2017),
(4, 'Lemonade', 2016),
(5, 'After Hours', 2020),
(6, 'ONE', 2019),
(7, 'Happier Than Ever', 2021),
(8, 'A Head Full of Dreams', 2015),
(9, '25', 2015),
(10, 'Hollywood\'s Bleeding', 2019);

-- Insert sample data into track table
INSERT INTO track (album_id, title, duration, genre)
VALUES
(1, 'Blank Space', 231, 'Pop'),
(2, 'Tum Hi Ho', 252, 'Bollywood'),
(3, 'Shape of You', 240, 'Pop'),
(4, 'Formation', 230, 'R&B'),
(5, 'Blinding Lights', 200, 'R&B'),
(6, 'Paagal', 220, 'Hip-Hop'),
(7, 'Bad Guy', 194, 'Alternative'),
(8, 'Adventure of a Lifetime', 243, 'Rock'),
(9, 'Hello', 295, 'Pop'),
(10, 'Circles', 215, 'Hip-Hop');

-- Insert sample data into user table
INSERT INTO user (name, email, subscription_type, country)
VALUES
('John Doe', 'john@example.com', 'premium', 'USA'),
('Jane Smith', 'jane@example.com', 'free', 'UK'),
('Raj Patel', 'raj@example.com', 'premium', 'India'),
('Emily Davis', 'emily@example.com', 'free', 'Canada'),
('Michael Brown', 'michael@example.com', 'premium', 'Australia'),
('Sarah Johnson', 'sarah@example.com', 'free', 'USA'),
('David Wilson', 'david@example.com', 'premium', 'UK'),
('Sophia Garcia', 'sophia@example.com', 'free', 'India'),
('James Lee', 'james@example.com', 'premium', 'Canada'),
('Olivia Martinez', 'olivia@example.com', 'free', 'Australia');

INSERT INTO play_history (user_id, track_id, play_date, duration_played)
VALUES
(1, 1, '2024-10-10 14:30:00', 230),
(2, 2, '2024-10-10 15:00:00', 240),
(3, 3, '2024-10-10 15:30:00', 200),
(4, 4, '2024-10-11 12:30:00', 230),
(5, 5, '2024-10-11 13:00:00', 190),
(1, 6, '2024-10-11 14:30:00', 210),
(2, 7, '2024-10-12 16:00:00', 194),
(3, 8, '2024-10-12 17:00:00', 240),
(4, 9, '2024-10-12 18:00:00', 295),
(5, 10, '2024-10-12 18:30:00', 215);

-- Insert sample data into the payment table
INSERT INTO payment (user_id, amount, payment_date)
VALUES
(1, 9.99, '2024-10-01'),
(2, 0.00, '2024-10-01'),  -- Free user
(3, 14.99, '2024-10-01'),
(4, 0.00, '2024-10-01'),  -- Free user
(5, 9.99, '2024-10-01'),
(6, 0.00, '2024-10-01'),  -- Free user
(7, 9.99, '2024-10-01'),
(8, 0.00, '2024-10-01'),  -- Free user
(9, 9.99, '2024-10-01'),
(10, 0.00, '2024-10-01');  -- Free user


CREATE VIEW top_played_tracks AS
SELECT t.title AS track_title, a.name AS artist_name, COUNT(p.play_id) AS play_count
FROM play_history p
JOIN track t ON p.track_id = t.track_id
JOIN album al ON t.album_id = al.album_id
JOIN artist a ON al.artist_id = a.artist_id
GROUP BY t.title, a.name
ORDER BY play_count DESC
LIMIT 5;

CREATE VIEW total_plays_per_genre AS
SELECT t.genre, COUNT(p.play_id) AS total_plays
FROM play_history p
JOIN track t ON p.track_id = t.track_id
GROUP BY t.genre
ORDER BY total_plays DESC;

CREATE VIEW total_play_time_by_user AS
SELECT u.name AS user_name, SUM(p.duration_played) AS total_play_time
FROM play_history p
JOIN user u ON p.user_id = u.user_id
GROUP BY u.name
ORDER BY total_play_time DESC;

CREATE VIEW revenue_by_country AS
SELECT u.country, SUM(pm.amount) AS total_revenue
FROM payment pm
JOIN user u ON pm.user_id = u.user_id
GROUP BY u.country
ORDER BY total_revenue DESC;

CREATE VIEW user_playlists AS
SELECT u.name AS user_name, pl.name AS playlist_name, COUNT(pt.track_id) AS total_tracks
FROM playlist pl
JOIN user u ON pl.user_id = u.user_id
JOIN playlist_track pt ON pl.playlist_id = pt.playlist_id
GROUP BY u.name, pl.name
ORDER BY u.name;

CREATE VIEW top_paying_users AS
SELECT u.name AS user_name, SUM(pm.amount) AS total_paid
FROM payment pm
JOIN user u ON pm.user_id = u.user_id
GROUP BY u.name
ORDER BY total_paid DESC
LIMIT 5;

CREATE VIEW recently_played_tracks AS
SELECT u.name AS user_name, t.title AS track_title, p.play_date
FROM play_history p
JOIN track t ON p.track_id = t.track_id
JOIN user u ON p.user_id = u.user_id
ORDER BY p.play_date DESC
LIMIT 10;

CREATE VIEW active_users_by_subscription AS
SELECT subscription_type, COUNT(user_id) AS total_users
FROM user
GROUP BY subscription_type;















