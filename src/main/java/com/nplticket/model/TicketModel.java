package com.nplticket.model;

public class TicketModel {
    private String id; // Changed from long to String
    private long userId;
    private long matchId;
    private String matchName;
    private String date;
    private String seat;
    private String status;
    private String fullName;

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }
    public long getMatchId() { return matchId; }
    public void setMatchId(long matchId) { this.matchId = matchId; }
    public String getMatchName() { return matchName; }
    public void setMatchName(String matchName) { this.matchName = matchName; }
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
    public String getSeat() { return seat; }
    public void setSeat(String seat) { this.seat = seat; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
}