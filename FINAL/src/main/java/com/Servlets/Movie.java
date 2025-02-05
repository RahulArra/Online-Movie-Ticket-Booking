package com.Servlets;

public class Movie {
    private String movieTitle;
    private String description;
    private String genre;
    private String releaseDate;
    private String posterImage;

    // Constructor
    public Movie(String movieTitle, String description, String genre, String releaseDate, String posterImage) {
        this.movieTitle = movieTitle;
        this.description = description;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.posterImage = posterImage;
    }

    // Getters
    public String getMovieTitle() {
        return movieTitle;
    }

    public String getDescription() {
        return description;
    }

    public String getGenre() {
        return genre;
    }



    public String getReleaseDate() {
        return releaseDate;
    }

    public String getPosterImage() {
        return posterImage;
    }
}
