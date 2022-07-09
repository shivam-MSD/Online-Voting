/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VotingSystemController;

import java.sql.Blob;

/**
 *
 * @author Admin
 */
public class Candidate {
    String cname;
    String partyname;
    String partylogo;
//    Blob partylogo;
    String position;
    String state;
    String city;
    String village;
    String municorpo;
    int wardno;
    String vid;
    long aadharno;
    String panno;
    String area;
    
    String year;
    

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getPartyname() {
        return partyname;
    }

    public void setPartyname(String partyname) {
        this.partyname = partyname;
    }

//    public Blob getPartylogo() {
//        return partylogo;
//    }
//
//    public void setPartylogo(Blob partylogo) {
//        this.partylogo = partylogo;
//    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getVillage() {
        return village;
    }

    public void setVillage(String village) {
        this.village = village;
    }

    public int getWardno() {
        return wardno;
    }

    public void setWardno(int wardno) {
        this.wardno = wardno;
    }

    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public long getAadharno() {
        return aadharno;
    }

    public void setAadharno(long aadharno) {
        this.aadharno = aadharno;
    }

    public String getPanno() {
        return panno;
    }

    public void setPanno(String panno) {
        this.panno = panno;
    }

    public String getMunicorpo() {
        return municorpo;
    }

    public void setMunicorpo(String municorpo) {
        this.municorpo = municorpo;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getPartylogo() {
        return partylogo;
    }

    public void setPartylogo(String partylogo) {
        this.partylogo = partylogo;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

}
