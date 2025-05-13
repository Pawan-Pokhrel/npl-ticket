package com.nplticket.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class MatchModel {
    private int matchId;
    private String team1;
    private String team2;
    private LocalDate date;
    private LocalTime time;
    private String venue;
    private int audience;
    private String status;

    public MatchModel() {
    }

    public MatchModel(int matchId, String team1, String team2, LocalDate date, LocalTime time, String venue, int audience, String status) {
        this.matchId = matchId;
        this.team1 = team1;
        this.team2 = team2;
        this.date = date;
        this.time = time;
        this.venue = venue;
        this.audience = audience;
        this.status  = status;
    }

    public int getMatchId() {
        return matchId;
    }

    public void setMatchId(int matchId) {
        this.matchId = matchId;
    }

    public String getTeam1() {
        return team1;
    }

    public void setTeam1(String team1) {
        this.team1 = team1;
    }

    public String getTeam2() {
        return team2;
    }

    public void setTeam2(String team2) {
        this.team2 = team2;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getTime() {
        return time;
    }

    public void setTime(LocalTime time) {
        this.time = time;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public int getAudience() {
        return audience;
    }

    public void setAudience(int audience) {
        this.audience = audience;
    }
    
    public String getStatus() {
    	return status;
    }
    
    public void setStatus(String status) {
    	this.status = status;
    }
}
