package com.nplticket.model;

public class TicketTypeModel {
    private int ticketTypeId;
    private String ticketType;
    private int unitPrice;
    private String ticketDesc;

    public TicketTypeModel() {}

    public TicketTypeModel(int ticketTypeId, String ticketType, int unitPrice, String ticketDesc) {
        this.ticketTypeId = ticketTypeId;
        this.ticketType = ticketType;
        this.unitPrice = unitPrice;
        this.ticketDesc = ticketDesc;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getTicketDesc() {
        return ticketDesc;
    }

    public void setTicketDesc(String ticketDesc) {
        this.ticketDesc = ticketDesc;
    }
}