MyGaana Music Platform - Database Design & Analytics
MyGaana is a simulated music streaming platform designed to analyze user behavior, track plays, subscription trends, and revenue using SQL. The project focuses on building a relational database to handle music streaming data and provide actionable insights.

Key Features:
Database Schema: Includes tables for users, artists, albums, tracks, play history, playlists, and payments.
Advanced SQL Queries: Implements queries using key SQL functions like JOIN, GROUP BY, COUNT(), SUM(), DISTINCT, and LIMIT to derive meaningful insights.
Analytics:
Top streamed genres and tracks
Distinct users per genre
Total playtime per user
Revenue by country
Top paying users
Recently played tracks
Active users by subscription type
Sample Data: Contains realistic sample data for testing queries, including users, artists, tracks, and payments.
Project Goals:
Streaming Analysis: Identify top genres and active users based on play history.
Revenue Insights: Analyze revenue per country and top-paying users.
User Engagement: Track recently played tracks and playlists to assess user activity.
Database Schema Overview:
artist: Artist details (name, genre, country).
album: Albums linked to artists.
track: Track details (duration, genre).
user: User information (subscription type, country).
play_history: Logs user track plays.
playlist: User-created playlists.
payment: Tracks user payments.
Technologies Used:
MySQL for database management.
SQL for querying and data analysis.
