/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stdSessionController;

import java.util.*;

public class Student {

    private String studentName;
    private String studentEmail;
    private Long studentMobile;
    private Date studentDoB;
    private ArrayList<String> studentSkills;

    private Address stdAddress;

    public Address getStdAddress() {
        return stdAddress;
    }

    public void setStdAddress(Address stdAddress) {
        this.stdAddress = stdAddress;
    }
    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public Long getStudentMobile() {
        return studentMobile;
    }

    public void setStudentMobile(Long studentMobile) {
        this.studentMobile = studentMobile;
    }

    public Date getStudentDoB() {
        return studentDoB;
    }

    public void setStudentDoB(Date studentDoB) {
        this.studentDoB = studentDoB;
    }

    public ArrayList<String> getStudentSkills() {
        return studentSkills;
    }

    public void setStudentSkills(ArrayList<String> studentSkills) {
        this.studentSkills = studentSkills;
    }
}
