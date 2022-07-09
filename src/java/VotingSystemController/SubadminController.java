/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VotingSystemController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Calendar;
import stdSessionController.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.BindingResult;

@Controller
@RequestMapping(value = "/Admin")
public class SubadminController {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView getAdminlogin(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        ModelAndView mv = new ModelAndView("StateAdminlogin");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("adminheader", "Admin Login");
        mv.addObject("formheader", "Admin Login");
        return mv;
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView getAdminloginsuccess(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        String aid = addadmin.getAid().trim();
        String vid;
        String email;
        String name;
        String panno;
        long aadharno;
        String password = addadmin.getPassword();
        String captcha = addadmin.getCaptcha();
        String captchahidden = addadmin.getCaptchahidden();

        EncryptDecryptPassword td;
        String decryptedpassword;
        String query;
        Connection con;
        PreparedStatement pst;

        if (captcha.equals(captchahidden)) {
            try {
                String viddb;
                long aadharnodb;
                String pannodb;
                String namedb = "";
                Long mobnodb;
                String passworddb = "";
                String statedb = "";
                String citydb = "";

                con = OnlinevotingDBConnection.createConnection();
                query = "select * from admin where AdminId = ?;";
                pst = con.prepareStatement(query);
                pst.setString(1, aid);

                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    passworddb = rs.getString("password");
                    statedb = rs.getString("state");
                    citydb = rs.getString("city");

                    try {
                        td = new EncryptDecryptPassword();

                        decryptedpassword = td.decrypt(passworddb);
//HeadAdminloginsuccess
//Adminloginsuccess
                        if (decryptedpassword.equals(password)) {
                            if (statedb == null) {
                                ModelAndView mv = new ModelAndView("AdminHeadloginsuccess");
                                mv.addObject("addadminmsg", addadmin);
                                mv.addObject("adminheader", "Admin Login");
                                return mv;
                            } else if (statedb != null && citydb == null) {
                                ModelAndView mv = new ModelAndView("Adminloginsuccess");
                                mv.addObject("addadminmsg", addadmin);
                                mv.addObject("adminheader", "Admin Login");
                                return mv;
                            } else {
                                ModelAndView mv = new ModelAndView("CityAdminloginsuccess");
                                mv.addObject("addadminmsg", addadmin);
                                mv.addObject("adminheader", "Admin Login");
                                return mv;
                            }

                        } else {
                            ModelAndView mv = new ModelAndView("StateAdminlogin");
                            mv.addObject("addadminmsg", addadmin);
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("error", "Incorrect password. Please enter correct password.");
                            return mv;
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                        ModelAndView mv = new ModelAndView("StateAdminlogin");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("adminheader", "Admin Login");
                        mv.addObject("error", "password encryption error");
                        return mv;
                    }

                } else {
                    ModelAndView mv = new ModelAndView("StateAdminlogin");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("adminheader", "Admin Login");
                    mv.addObject("formheader", "Edit Admin");
                    mv.addObject("error", "AdminId not found. Please enter correct AdminId to login.");
                    return mv;
                }
            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("StateAdminlogin");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("adminheader", "Admin Login");
                mv.addObject("error", "connection error");
                return mv;

            }
        } else {
            ModelAndView mv = new ModelAndView("StateAdminlogin");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("adminheader", "Admin Login");
            mv.addObject("formheader", "Admin Login");
            mv.addObject("error", "Please enter correct captcha code.");
            return mv;
        }
    }

    @RequestMapping(value = "/login/admindashboard", method = RequestMethod.GET)
    public ModelAndView getAdminDashboard() {
        ModelAndView mv = new ModelAndView("AdminDashboard");
        mv.addObject("adminheader", "Admin Dashboard");
        mv.addObject("aid", "Admin Dashboard");
        mv.addObject("msg", "Admin Dashboard");
        return mv;
    }

    @RequestMapping(value = "/login/admindashboard/addsubadmin", method = RequestMethod.GET)
    public ModelAndView addNewSubAdmin(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {
        ModelAndView mv = new ModelAndView("AddnewSubadmin");
        mv.addObject("adminheader", "Admin Dashboard");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("formheader", "Add New  SubAdmin");
        return mv;
    }

//    @RequestMapping(value = "/login/adminheaddashboard/addadmin/checkadmindetails", method = RequestMethod.POST)
    @RequestMapping(value = "/login/admindashboard/addsubadmin", method = RequestMethod.POST)
    public ModelAndView addNewSubAdmincheckdetails(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        if (result.hasErrors()) {
            ModelAndView mv = new ModelAndView("AddnewSubadmin");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Add New SubAdmin");
            return mv;
        }
        String aid = addadmin.getAid().trim();
        String vid = addadmin.getVid().trim();
        String email;
        String name;
        String panno;
        long aadharno;

        Connection con;
        PreparedStatement pst;

        try {
            String viddb;
            long aadharnodb;
            String pannodb;
            String namedb;
            Long mobnodb;
            con = OnlinevotingDBConnection.createConnection();
            String query = "select * from Admin where AdminId = ?;";
            pst = con.prepareStatement(query);
            pst.setString(1, aid);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                ModelAndView mv = new ModelAndView("AddNewSubadmin");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Add New SubAdmin");
                mv.addObject("error", "Admin having adminID = '" + aid + "' is already added");
                return mv;
            } else {
                query = "select * from Admin where VoterID = ?;";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                    ModelAndView mv = new ModelAndView("AddnewSubadmin");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Add New SubAdmin");
                    mv.addObject("error", "Admin having voterID = '" + vid + "' is already added");
                    return mv;
                } else {

                    query = "select * from voter where VoterID = ?;";
                    pst = con.prepareStatement(query);
                    pst.setString(1, vid);

                    rs = pst.executeQuery();

                    if (rs.next()) {
                        viddb = rs.getString("VoterID");
                        aadharnodb = rs.getLong("Aadhar_Number");
                        pannodb = rs.getString("Pan_Number");
                        namedb = rs.getString("Name");
                        mobnodb = rs.getLong("MobileNo");

                        addadmin.setAadharno(aadharnodb);
                        addadmin.setPanno(pannodb);
                        addadmin.setMobno(mobnodb);
                        addadmin.setName(namedb);

                        ModelAndView mv = new ModelAndView("AddnewSubadmincheckdetails");
                        mv.addObject("adminheader", "Admin Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Add New SubAdmin");
                        return mv;

                    } else {
                        ModelAndView mv = new ModelAndView("AddnewSubadmin");
                        mv.addObject("adminheader", "Admin Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Add New SubAdmin");
                        mv.addObject("error", "VoterID not found. Please enter correct VoterID.");
                        return mv;
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("AddNewSubadmin");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Add New SubAdmin");
            mv.addObject("error", "connection error");
            return mv;
        }
    }

    @RequestMapping(value = "/login/admindashboard/addsubadminsuccess", method = RequestMethod.POST)
    public ModelAndView addNewSubAdminSuccess(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        String vid = addadmin.getVid().trim();
        String email = addadmin.getEmail().trim();
        String name = addadmin.getName().trim();
        String panno = addadmin.getPanno().trim();
        long aadharno = addadmin.getAadharno();
        long mobno = addadmin.getMobno();
        String statefetch = addadmin.getState();
        String state[] = statefetch.split(":");
//        String cityfetch = addadmin.getCity();
//        String city[] = cityfetch.split(":");
//        String state = addadmin.getState();
        String city = addadmin.getCity();
        String village = "";
        String aid = addadmin.getAid().trim();

        Connection con;
        PreparedStatement pst;
        String query;

        try {
            query = "select * from admin where state = ? && city = ?;";
            con = OnlinevotingDBConnection.createConnection();
            pst = con.prepareStatement(query);
            pst.setString(1, state[1]);
            pst.setString(2, city);

            ResultSet rs = pst.executeQuery();
            int count = 0;
            int checkstatecount = 0;
            while (rs.next()) {
                if (count >= 1) {
                    break;
                } else {
                    checkstatecount = 1;
                }
            }
            if (checkstatecount == 0) {
                Mail m = new Mail();
                String password = m.generateAdminPassword(vid, aid, state[1], city, village, email, name);
                EncryptDecryptPassword td;
                String encryptedPassword = "";
                String decryptedPassword = "";
                try {
                    td = new EncryptDecryptPassword();
                    encryptedPassword = td.encrypt(password);
                    decryptedPassword = td.decrypt(encryptedPassword);
                } catch (Exception e) {
                    ModelAndView mv = new ModelAndView("AddnewSubadmin");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Add New Admin");
                    mv.addObject("error", "Password encryption error");
                    return mv;
                }

                addadmin.setRole("Admin");
                String role = addadmin.getRole();

                try {
                    con = OnlinevotingDBConnection.createConnection();
                    query = "insert into Admin(AdminId,VoterID,Aadhar_Number,Pan_Number,Name,MobileNo,Role,password,state,city,email) values('" + aid + "','" + vid + "'," + aadharno + ",'" + panno + "','" + name + "'," + mobno + ",'" + role + "','" + encryptedPassword + "','" + state[1] + "','" + city + "','" + email + "');";
                    Statement st = con.createStatement();
                    st.executeUpdate(query);

//                      m.generateAdminPassword(vid, aid, state, city, village, email, name)
//                      m.generateAdminPassword("","", "", "", "", "", "");
                    String sendEmailTo = email;
                    String subject = "Evoting Admin Selection";
                    String mailbody = "Hello " + name + ",\n\t\tYou are selected as EVoting Subdmin i.e. Admin of city.Your details are display below : \nAdminID :-" + aid + "\nPassword for Admin Login :- " + password + "\nYour VoterID :- " + vid + "\nEvoting Admin of City :- " + city + " [" + state[1] + "]\n\nIf you want to update your password, click on the link below.";

                    m.sendMailNow(sendEmailTo, subject, mailbody);
                    ModelAndView mv = new ModelAndView("AddnewSubadminSuccess");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("msg", "Admin Dashboard");
                    return mv;
                } catch (Exception e) {
                    e.printStackTrace();
                    ModelAndView mv = new ModelAndView("AddnewSubadmincheckdetails");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Add New Admin");
                    mv.addObject("error", "Something went wrong");
                    return mv;
                }
            } else {
                ModelAndView mv = new ModelAndView("AddnewSubadmincheckdetails");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Add New Admin");
                mv.addObject("error", "You can only add one city admin per city.");
                return mv;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("AddnewSubadmincheckdetails");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Add New Admin");
            mv.addObject("error", "Something went wrong");
            return mv;
        }

    }

    @RequestMapping(value = "/login/admindashboard/editsubadmin", method = RequestMethod.GET)
    public ModelAndView editSubAdminform(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {
        ModelAndView mv = new ModelAndView("EditSubAdmin");
        mv.addObject("adminheader", "Admin Head Dashboard");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("formheader", "Edit Subadmin");
        mv.addObject("error", "Enter appropriate AdminID to edit Subadmin details");
        return mv;
    }

    @RequestMapping(value = "/login/admindashboard/editsubadmin", method = RequestMethod.POST)
    public ModelAndView editSubAdminformcheckadmindetails(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        String aid = addadmin.getAid().trim();
        String vid = addadmin.getVid().trim();
        String email;
        String name;
        String panno;
        long aadharno;

        Connection con;
        PreparedStatement pst;

        try {
            String aiddb;
            String viddb;
            long aadharnodb;
            String pannodb;
            String namedb;
            Long mobnodb;
            String emaildb;
            String statedb;
            String citydb;

            con = OnlinevotingDBConnection.createConnection();
            String query = "select * from Admin where AdminId = ?;";
            pst = con.prepareStatement(query);
            pst.setString(1, aid);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                viddb = rs.getString("VoterID");

                if (vid.equals(viddb)) {
                    viddb = rs.getString("VoterID");
                    aadharnodb = rs.getLong("Aadhar_Number");
                    pannodb = rs.getString("Pan_Number");
                    namedb = rs.getString("Name");
                    mobnodb = rs.getLong("MobileNo");
                    emaildb = rs.getString("Email");
                    statedb = rs.getString("state");
                    citydb = rs.getString("city");

                    addadmin.setAadharno(aadharnodb);
                    addadmin.setPanno(pannodb);
                    addadmin.setAid(aid);
                    addadmin.setVid(viddb);
                    addadmin.setMobno(mobnodb);
                    addadmin.setName(namedb);
                    addadmin.setEmail(emaildb);
                    addadmin.setState(statedb);
                    addadmin.setCity(citydb);

                    if (statedb == null) {
                        ModelAndView mv = new ModelAndView("EditSubAdmin");
                        mv.addObject("adminheader", "Admin Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Subadmin");
                        mv.addObject("error", "You are not allowed to edit Admin head details.");
                        return mv;
                    } else if (statedb != null && citydb == null) {
                        ModelAndView mv = new ModelAndView("EditSubAdmin");
                        mv.addObject("adminheader", "Admin Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Subadmin");
                        mv.addObject("error", "You are not allowed to edit Admin details. You are only allowed to edit subadmin details.");
                        return mv;
                    } else if (statedb != null && citydb != null) {

                        ModelAndView mv = new ModelAndView("EditSubAdmincheckdetails");
                        mv.addObject("adminheader", "Admin Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Subadmin");
//                            mv.addObject("error", "Sub admin is not authenticated");
//                        mv.addObject("displayemail", stateadminemail);
                        return mv;

                    } //                else if (statedb != null)
                    else {
                        ModelAndView mv = new ModelAndView("EditSubAdmin");
                        mv.addObject("adminheader", "Admin Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Subdmin");
                        mv.addObject("error", "Something went wrong");
                        return mv;
                    }
                } else {
                    ModelAndView mv = new ModelAndView("EditSubAdmin");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Edit Subadmin");
                    mv.addObject("error", "Voterid of this admin is incorrect. Please enter correct voterid");
                    return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("EditSubAdmin");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Edit Subdmin");
                mv.addObject("error", "AdminId not found. Please enter correct AdminID.");
                return mv;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditSubAdmin");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Edit Sudmin");
            mv.addObject("error", "connection error");
            return mv;
        }

    }

    @RequestMapping(value = "/login/admindashboard/editsubadmin/editsubadminsuccess", method = RequestMethod.POST)
    public ModelAndView editSubAdminformsuccss(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        String aid = addadmin.getAid().trim();
        String vid = addadmin.getVid().trim();
        String email = addadmin.getEmail();
        String name = addadmin.getName();
        String panno = addadmin.getPanno();
        long aadharno = addadmin.getAadharno();
        String state = addadmin.getState();
        long mobno = addadmin.getMobno();
        String city = addadmin.getCity();

        Connection con;
        PreparedStatement pst;

        try {
            String aiddb;
            String viddb;
            long aadharnodb;
            String pannodb;
            String namedb;
            Long mobnodb;
            String emaildb;
            String statedb;
            String citydb;

            con = OnlinevotingDBConnection.createConnection();
            String query = "update admin set email = ? , MobileNo = ? , Name = ? where AdminId = ? and VoterID = ?;";
            pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setLong(2, mobno);
            pst.setString(3, name);
            pst.setString(4, aid);
            pst.setString(5, vid);

            boolean ans = pst.execute();

            if (ans) {
                ModelAndView mv = new ModelAndView("EditSubAdmincheckdetails");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Edit Subadmin");
                mv.addObject("error", "connection error");
                return mv;
            } else {
                Mail m = new Mail();
                String sendEmailTo = email;
                String subject = "Evoting Subadmin details updated";
                String mailbody = "Hello " + name + ",\n\t\tYour Subdmin details are updated succssfully.Your details are display below : \nAdminID :- " + aid + "\nYour VoterID :- " + vid + "\nName :- " + name + "\nEvoting Admin of State :- " + state + "\nCity :- " + city + "\nMobile No. :- " + mobno;

                m.sendMailNow(sendEmailTo, subject, mailbody);
                ModelAndView mv = new ModelAndView("EditsubadminSuccess");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("msg", "Admin Dashboard");
                return mv;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditSubAdmincheckdetails");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Edit Subadmin");
            mv.addObject("error", "connection error");
            return mv;

        }

    }

    @RequestMapping(value = "/login/admindashboard/removeadmin", method = RequestMethod.POST)
    public ModelAndView deleteSubAdminformsuccss(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {
        String aid = addadmin.getAid().trim();

        Connection con;
        PreparedStatement pst;

        try {
            String aiddb;
            String viddb;
            long aadharnodb;
            String pannodb;
            String namedb;
            Long mobnodb;
            String emaildb;
            String statedb;
            String citydb;

            con = OnlinevotingDBConnection.createConnection();

            String query = "select * from admin where AdminId = ?;";
            pst = con.prepareStatement(query);
            pst.setString(1, aid);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                statedb = rs.getString("state");
                citydb = rs.getString("city");

                if (statedb != null && citydb != null) {
                    addadmin.setState("subadminremove");
//                    addadmin.setCity(citydb);
                } else if ((statedb != null && citydb == null) || (statedb == null && citydb == null)) {
                    addadmin.setState("adminremove");
                }

                query = "delete from admin where AdminId = '" + aid + "';";
                Statement st = con.createStatement();

                int ans = st.executeUpdate(query);
                if (ans != 0) {
                    ModelAndView mv = new ModelAndView("RemoveAdminsuccess");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("adminheader", "Admin Head Dashboard");
                    mv.addObject("msg", "Admin Dashboard");
                    return mv;
                } else {
                    ModelAndView mv = new ModelAndView("RemoveAdminsuccess");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("adminheader", "Admin Head Dashboard");
                    mv.addObject("msg", "Admin Dashboard");
                    mv.addObject("aid", aid);
                    return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("RemoveAdminsuccess");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("adminheader", "Admin Head Dashboard");
                mv.addObject("msg", "Admin Dashboard");
                mv.addObject("aid", aid);
                return mv;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("RemoveAdminsuccess");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("adminheader", "Admin Head Dashboard");
            mv.addObject("msg", "Admin Dashboard");
            return mv;
        }
    }

    // ************************************************** candidate operation starts from here
    @RequestMapping(value = "/login/admindashboard/addcandidate", method = RequestMethod.GET)
    public ModelAndView addNewStateCandidate(@ModelAttribute("candidate") Candidate candidate) {
        ModelAndView mv = new ModelAndView("Addcandidatebyadmin");
        mv.addObject("adminheader", "Admin Dashboard");
        mv.addObject("candi", candidate);
        mv.addObject("formheader", "Add Candidate");
//        mv.addObject("error", "connection error");
        return mv;
    }

    @RequestMapping(value = "/login/admindashboard/addcandidate", method = RequestMethod.POST)
    public ModelAndView addNewStateCandidatecheckdetails(@ModelAttribute("candidate") Candidate candidate) {
        String vid = candidate.getVid();
        String position = candidate.getPosition();
//        String position[] = positionfetch.split(":");

        candidate.setPosition(position);
        Connection con;
        PreparedStatement pst;
        String query;
        try {
            query = "select * from voter where VoterID = ?;";
            con = OnlinevotingDBConnection.createConnection();
            pst = con.prepareStatement(query);
            pst.setString(1, vid);

            ResultSet rs = pst.executeQuery();

            String viddb;
            String pannodb;
            String cnamedb;
            long aadharnodb;
//            String
            if (rs.next()) {

                query = "select * from candidate where VoterID = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                ResultSet rst = pst.executeQuery();

                if (rst.next()) {
                    ModelAndView mv = new ModelAndView("Addcandidatebyadmin");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Add Candidate");
                    mv.addObject("error", "Candidate whose Voterid = '" + vid + "' is already added.");
                    return mv;
                } else {
                    viddb = rs.getString("VoterID");
                    pannodb = rs.getString("Pan_Number");
                    aadharnodb = rs.getLong("Aadhar_Number");
                    cnamedb = rs.getString("Name");

                    candidate.setVid(viddb);
                    candidate.setPanno(pannodb);
                    candidate.setPosition(position);
                    candidate.setAadharno(aadharnodb);
                    candidate.setCname(cnamedb);

                    ModelAndView mv = new ModelAndView("Addcandidatebyadmincheckdetails");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Add Candidate");
                    mv.addObject("error", "Verify all details of candidate and select partylogo and state.");
                    return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("Addcandidatebyadmin");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Add Candidate");
                mv.addObject("error", "Voterid not found. Please enter correct voterid.");
                return mv;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("Addcandidatebyadmin");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Add Candidate");
            mv.addObject("error", "connection error");
            return mv;
        }

    }

    // addcandidatesuccess
    @RequestMapping(value = "login/admindashboard/addcandidatesuccess", method = RequestMethod.POST)
    public ModelAndView addNewStateCandidatesuccess(@ModelAttribute("candidate") Candidate candidate) {
        Connection con;
        PreparedStatement pst;

        String vid = candidate.getVid();
        String cname = candidate.getCname();
        String panno = candidate.getPanno();
        String position = candidate.getPosition();
        String partylogo = candidate.getPartylogo();
//        Blob partylogo = candidate.getPartylogo();
        long aadharno = candidate.getAadharno();
        String statefetch = candidate.getState();
        String statearr[] = statefetch.split(":");
        String state = statearr[1];
        String city = candidate.getCity();
        String partyname = candidate.getPartyname();

        String query = "select * from candidate where state = ? and city = ? and party_name = ? and (position ='MLA' or position = 'MP')";
        try {
            con = OnlinevotingDBConnection.createConnection();
            pst = con.prepareStatement(query);
            pst.setString(1, state);
            pst.setString(2, city);
            pst.setString(3, partyname);

            ResultSet rs = pst.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
            }

            if (count == 0) {
//                query = "insert into Admin(AdminId,VoterID,Aadhar_Number,Pan_Number,Name,MobileNo,Role,password,state,city,email) values('" + aid + "','" + vid + "'," + aadharno + ",'" + panno + "','" + name + "'," + mobno + ",'" + role + "','" + encryptedPassword + "','" + state + "','" + city + "','" + email + "');";

                query = "insert into candidate(VoterID,candidate_name,party_name,position,party_logo,state,city,village,wardno,area) values('" + vid + "','" + cname + "','" + partyname + "','" + position + "','" + partylogo + "','" + state + "','" + city + "','" + "',0,'');";
                Statement st = con.createStatement();
                st.executeUpdate(query);

                ModelAndView mv = new ModelAndView("Addcandidatebyadminsuccess");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Add Candidate");
                mv.addObject("error", "You can only add one candidate of any party. Please select correcr city and state.");
                return mv;
            } else {
                ModelAndView mv = new ModelAndView("Addcandidatebyadmincheckdetails");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Add Candidate");
                mv.addObject("error", "You can only add one candidate of any party. Please select correcr city and state.");
                return mv;

            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("Addcandidatebyadmincheckdetails");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Add Candidate");
            mv.addObject("error", "Connnection error.");
            return mv;
        }
    }

    // Edit candidate details
    @RequestMapping(value = "/login/admindashboard/editcandidate", method = RequestMethod.GET)
    public ModelAndView editStateCandidate(@ModelAttribute("candidate") Candidate candidate) {
        ModelAndView mv = new ModelAndView("EditCandidatebyadmin");
        mv.addObject("adminheader", "Admin Dashboard");
        mv.addObject("candi", candidate);
        mv.addObject("formheader", "Edit Candidate");
        mv.addObject("error", "");
        return mv;
    }

    @RequestMapping(value = "/login/admindashboard/editcandidate", method = RequestMethod.POST)
    public ModelAndView editStateCandidatecheckdetails(@ModelAttribute("candidate") Candidate candidate) {
        String vid = candidate.getVid();
        String position = candidate.getPosition();
        String partyname = candidate.getPartyname();
//        String position[] = positionfetch.split(":");

        candidate.setPosition(position);
        Connection con;
        PreparedStatement pst;
        String query;
        try {
            query = "select * from candidate where VoterID = ?;";
            con = OnlinevotingDBConnection.createConnection();
            pst = con.prepareStatement(query);
            pst.setString(1, vid);

            ResultSet rs = pst.executeQuery();

            String viddb;
            String partynamedb;
            String cnamedb;
            String positiondb;
//            Blob partylogodb;
            String partylogodb;
            String statedb;
            String citydb;
            long aadharnodb;
//            String
            if (rs.next()) {
                positiondb = rs.getString("position");

//                if((positiondb.equals('MLA')) || (positiondb.equals('MP')))
                if (position.equals("MLA") || position.equals("MP")) {
                    viddb = rs.getString("VoterID");
                    partynamedb = rs.getString("party_name");
                    positiondb = rs.getString("position");
                    cnamedb = rs.getString("candidate_name");
                    statedb = rs.getString("state");
                    citydb = rs.getString("city");
//                partylogodb = rs.getBlob("party_logo");
                    partylogodb = rs.getString("party_logo");

                    candidate.setVid(vid);
                    candidate.setPartyname(partyname);
                    candidate.setPartylogo(partylogodb);
                    candidate.setCname(cnamedb);
                    candidate.setState(statedb);
                    candidate.setCity(citydb);
                    candidate.setPosition(position);

                    ModelAndView mv = new ModelAndView("EditCandidatebyadmincheckdetails");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Edit Candidate");
                    mv.addObject("error", "Verify all details of candidate and update the fields which you want to update.");
                    return mv;
                } else {
                    ModelAndView mv = new ModelAndView("EditCandidatebyadmin");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Edit Candidate");
                    mv.addObject("error", "You can only edit city candidate details.");
                    return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("EditCandidatebyadmin");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Edit Candidate");
                mv.addObject("error", "Candidate of Voterid = '" + vid + "' is not found. Please enter correct voterid.");
                return mv;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditCandidatebyadmin");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Edit Candidate");
            mv.addObject("error", "connection error");
            return mv;
        }
    }

    // editcandidatesuccess
    @RequestMapping(value = "login/admindashboard/editcandidatesuccess", method = RequestMethod.POST)
    public ModelAndView editStateCandidatesuccess(@ModelAttribute("candidate") Candidate candidate) {
        Connection con;
        PreparedStatement pst;

        String vid = candidate.getVid();
        String cname = candidate.getCname();
        String position = candidate.getPosition();
//        Blob partylogo = candidate.getPartylogo();
        String partylogo = candidate.getPartylogo();
        String statefetch = candidate.getState();
        String statearr[] = statefetch.split(":");
        String state = statearr[1];
        String city = candidate.getCity();
        String partyname = candidate.getPartyname();

        String query = "select * from candidate where state = ? and city = ? and party_name = ? and area is null and village = ? and wardno = ?;";
        try {
            con = OnlinevotingDBConnection.createConnection();
            pst = con.prepareStatement(query);
            pst.setString(1, state);
            pst.setString(2, city);
            pst.setString(3, partyname);
            pst.setString(4, "");
            pst.setInt(5, 0);

            ResultSet rs = pst.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
            }

            if (count == 0) {
//                query = "insert into Admin(AdminId,VoterID,Aadhar_Number,Pan_Number,Name,MobileNo,Role,password,state,city,email) values('" + aid + "','" + vid + "'," + aadharno + ",'" + panno + "','" + name + "'," + mobno + ",'" + role + "','" + encryptedPassword + "','" + state + "','" + city + "','" + email + "');";

//                query = "update candidate set party_name = ? , position = ? , party_logo = ? , state = ? , city = ? where VoterID = ? ;";
//                pst.setString(1, partyname);
//                pst.setString(2, position);
////                pst.setBlob(3, partylogo);
//                pst.setString(3, partylogo);
//                pst.setString(4, state);
//                pst.setString(5, city);
//                pst.setString(6, vid);
                query = "update candidate set party_name = '" + partyname + "' , position = '" + position + "' , party_logo = '" + partylogo + "' , state = '" + state + "' , city = '" + city + "' where VoterID = '" + vid + "' ;";
                Statement st = con.createStatement();

//                boolean ans = pst.execute();
                boolean ans = st.execute(query);

                if (ans) {
                    ModelAndView mv = new ModelAndView("EditCandidatebyadmincheckdetails");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Edit Candidate");
                    mv.addObject("error", "Error in updating candidate details.Please check all the details.");
                    return mv;
                } else {
                    ModelAndView mv = new ModelAndView("EditCandidatebyadminsuccess");
                    mv.addObject("adminheader", "Admin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Edit Candidate");
//                mv.addObject("error", "You can only add one candidate of any party. Please select correcr city and state.");
                    return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("EditCandidatebyadmincheckdetails");
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Edit Candidate");
                mv.addObject("error", "You can only add one candidate of any party. Please select correcr city and state.");
                return mv;

            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditCandidatebyadmincheckdetails");
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Edit Candidate");
            mv.addObject("error", "Connnection error.");
            return mv;
        }
    }

    // delete candidate details
    @RequestMapping(value = "/login/admindashboard/removecandidate", method = RequestMethod.POST)
    public ModelAndView deletecandidateformsuccss(@ModelAttribute("candidate") Candidate candidate) {
        String vid = candidate.getVid().trim();
        Connection con;
        PreparedStatement pst;

        try {
            String viddb;
            String namedb;
            String statedb;
            String citydb;
            String villagedb;

            con = OnlinevotingDBConnection.createConnection();

//            String query = "select * from admin where AdminId = ?;";
//            pst = con.prepareStatement(query);
//            pst.setString(1, aid);
//            ResultSet rs = pst.executeQuery();
//            if (rs.next()) {
//                statedb = rs.getString("state");
//                citydb = rs.getString("city");
//                if (statedb != null && citydb != null) {
//                    addadmin.setState("subadminremove");
////                    addadmin.setCity(citydb);
//                } else if ((statedb != null && citydb == null) || (statedb == null && citydb == null)) {
//                    addadmin.setState("adminremove");
//                }
            String query = "delete from candidate where VoterID = '" + vid + "';";
            Statement st = con.createStatement();

            int ans = st.executeUpdate(query);
            if (ans != 0) {
                ModelAndView mv = new ModelAndView("RemoveCanditatebyadminsuccess");
                mv.addObject("candidate", candidate);
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("msg", "Admin Dashboard");
                return mv;
            } else {
                ModelAndView mv = new ModelAndView("RemoveCanditatebyadminsuccess");
                mv.addObject("candidate", candidate);
                mv.addObject("adminheader", "Admin Dashboard");
                mv.addObject("msg", "Admin Dashboard");
//                    mv.addObject("aid", aid);
                return mv;
            }

//            } else {
//                ModelAndView mv = new ModelAndView("RemoveAdminsuccess");
//                mv.addObject("addadminmsg", addadmin);
//                mv.addObject("adminheader", "Admin Head Dashboard");
//                mv.addObject("msg", "Admin Dashboard");
//                mv.addObject("aid", aid);
//                return mv;
//            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("RemoveCanditatebyadminsuccess");
            mv.addObject("candidate", candidate);
            mv.addObject("adminheader", "Admin Dashboard");
            mv.addObject("msg", "Admin Dashboard");
            return mv;
        }
    }

    @RequestMapping(value = "login/admindashboard/logout", method = RequestMethod.POST)
    public ModelAndView logOutCityAdmin(@ModelAttribute("addadminmsg") AddNewAdmin addadmin) {
        ModelAndView mv = new ModelAndView("StateAdminLogout");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("adminheader", "Admin Login");
        mv.addObject("formheader", "Admin Login");
        return mv;
    }
    
    @RequestMapping(value = "/changepassword" , method = RequestMethod.GET)
    public ModelAndView changePassword(@ModelAttribute("addadminmsg") AddNewAdmin addadmin)
    {
        ModelAndView mv = new ModelAndView("StateAdminChangePassword");
        mv.addObject("adminheader", "Admin Login");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("formheader", "Admin Change Password");
        return mv;
    }
    
    @RequestMapping(value = "/changepassword" , method = RequestMethod.POST)
    public ModelAndView changePasswordSuccess(@ModelAttribute("addadminmsg") AddNewAdmin addadmin)
    {
        String aid = addadmin.getAid();
        String oldpassword = addadmin.getOldpassword();
        String newpassword = addadmin.getNewpassword();
        String confirmnewpassword = addadmin.getConfirmnewpassword();
        String captcha = addadmin.getCaptcha();
        String hiddencaptcha = addadmin.getCaptchahidden();
        
        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;
        if(captcha.equals(hiddencaptcha))
        {
            try
            {
                con = OnlinevotingDBConnection.createConnection();
                query = "select * from admin where AdminId = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, aid);
                rs = pst.executeQuery();
                
                addadmin.setAid(aid);
                
                if(rs.next())
                {
                    String oldencryptedpassworddb = rs.getString("password");
                    EncryptDecryptPassword t = new EncryptDecryptPassword();
                    String oldencryptedpassword = t.decrypt(oldencryptedpassworddb);
                    
                    if(confirmnewpassword.equals(newpassword))
                    {
//                        if(oldpassword.equals(oldencryptedpassworddb))
                        if(oldpassword.equals(oldencryptedpassword))
                        {
                            String newencryptedpassword = t.encrypt(newpassword);
                            query = "update admin set password = '" + newencryptedpassword + "' where AdminId = '" + aid + "';";
                            Statement st = con.createStatement();
                            st.execute(query);
                            
                            ModelAndView mv = new ModelAndView("StateAdminChangePasswordSuccess");
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("formheader", "Admin Change Password");
                            mv.addObject("addadminmsg", addadmin);
//                            mv.addObject("error","Please enter correct old password.");
                            return mv;
                        }
                        else
                        {
                            ModelAndView mv = new ModelAndView("StateAdminChangePassword");
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("formheader", "Admin Change Password");
                            mv.addObject("error","Please enter correct old password.");
                            mv.addObject("addadminmsg", addadmin);
                            return mv;
                        }
                    }
                    else
                    {
                        ModelAndView mv = new ModelAndView("StateAdminChangePassword");
                        mv.addObject("adminheader", "Admin Login");
                        mv.addObject("formheader", "Admin Change Password");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("error","Please enter correct confirm password.");
                        return mv;
                    }
                }
                else
                {
                    ModelAndView mv = new ModelAndView("StateAdminChangePassword");
                    mv.addObject("adminheader", "Admin Login");
                    mv.addObject("formheader", "Admin Change Password");
                    mv.addObject("error","Adminid not found. Please enter correct adminid.");
                    mv.addObject("addadminmsg", addadmin);
                    return mv;
                }
                
            }
            catch(Exception e)
            {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("StateAdminChangePassword");
                mv.addObject("adminheader", "Admin Login");
                mv.addObject("formheader", "Admin Change Password");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("error","Connection error + oldpass" + oldpassword + " newpass = " + newpassword + " newconfirmpass = " + confirmnewpassword);
                return mv;
            }
            
        }
        else
        {
            ModelAndView mv = new ModelAndView("StateAdminChangePassword");
            mv.addObject("adminheader", "Admin Login");
            mv.addObject("formheader", "Admin Change Password");
            mv.addObject("error","Please enter correct captcha code");
            return mv;
        }
        
    }
    
    
    //    startelectionprocessincity
    @RequestMapping(value = "login/admindashboard/startelectionprocessinstate", method = RequestMethod.POST)
    public ModelAndView StartElectionProcessInCity(@ModelAttribute("addadminmsg")  AddNewAdmin addadmin) {
        
        String aid = addadmin.getAid();
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        String query;
        String statedb;
        String citydb;
        String areadb;
        String villagedb;
        String vidfromvoter;
        String currentelectionadminstatus;
        
        
        String vidofcandidatedb;
        String cnamedb;
        String partynamedb;
        String positiondb;
        String partylogodb;
        int wardnodb;
        long votecount;
        
        try
        {
            
            con = OnlinevotingDBConnection.createConnection();
            
            query = "select * from  admin where AdminId = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, aid);
            
            rs = pst.executeQuery();
            
           if(rs.next())
           {
               statedb = rs.getString("state");
//               citydb = rs.getString("city");
               currentelectionadminstatus = rs.getString("ElectionStatus");
               
               if(currentelectionadminstatus.equals("Started"))
               {
                    query = "update admin set ElectionStatus = 'Not started' where AdminId = ?";
                    pst = con.prepareStatement(query);
                    pst.setString(1, aid);
                    pst.execute();
                    
                    // store votes into result table
                    
                    Year y = Year.now();

                   java.util.Date date = Calendar.getInstance().getTime();  
                   DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
                   String strDate = dateFormat.format(date);  

//                    String year = y.format(DateTimeFormatter.ofLocalizedDate(y.MEDIUM));
//                    query = "select * from candidate where state = ? and city = ?;";
                    query = "select * from candidate where state = ?";
                    
                    pst = con.prepareStatement(query);
                    pst.setString(1, statedb);
//                    pst.setString(2, citydb);
                    
                    rs = pst.executeQuery();
                    
                    while(rs.next())
                    {
                        vidofcandidatedb = rs.getString("VoterID");
                        cnamedb = rs.getString("candidate_name");
                        partynamedb = rs.getString("party_name");
                        positiondb = rs.getString("position");
                        partylogodb = rs.getString("party_logo");
                        villagedb = rs.getString("village");
                        areadb = rs.getString("area");
                        wardnodb = rs.getInt("wardno");
                        votecount = rs.getInt("votecount");
                        citydb = rs.getString("city");
                        
                        
//                        String query2 = "insert into electionresult values(" + YearOfElection + ",'" + vidofcandidatedb + "','"+ cnamedb + "','" + partynamedb +"','" + positiondb + "','" + partylogodb + "','" + statedb + "','" + citydb + "','" + villagedb + "'," + wardnodb + ",'" + areadb + "'," + votecount +  ")";

//                        String query2 = "insert into electionresult values(" + y + ",'" + vidofcandidatedb + "','"+ cnamedb + "','" + partynamedb +"','" + positiondb + "','" + partylogodb + "','" + statedb + "','" + citydb + "','" + villagedb + "'," + wardnodb + ",'" + areadb + "'," + votecount +  ")";

                        
                        String query2 = "insert into electionresult values(" + y + ",'" + vidofcandidatedb + "','"+ cnamedb + "','" + partynamedb +"','" + positiondb + "','" + partylogodb + "','" + statedb + "','" + citydb + "','" + villagedb + "'," + wardnodb + ",'" + areadb + "'," + votecount +  ")";

                        Statement st = con.createStatement();
                        st.execute(query2);
                        
                        query2 = "delete from candidate where VoterID = ?";
                        pst = con.prepareStatement(query2);
                        pst.setString(1, vidofcandidatedb);
                        pst.execute();
                        
                            String query3 = "select * from voter where city = ? and state = ? and village = ?;";
                            pst = con.prepareStatement(query3);
                            pst.setString(1, citydb);
                            pst.setString(2, statedb);
                            pst.setString(3,villagedb);

                            ResultSet rs2 = pst.executeQuery();

                            while(rs2.next())
                            {
                                String votervid = rs2.getString("VoterID");
                                
                               String query4 = "update registration set ElectionStatus = 'Not started' , status = 'Not voted' where VoterID = ?";
                                  pst = con.prepareStatement(query4);
                                  pst.setString(1, votervid);
                                  pst.execute();
                            }
                    }
                    ModelAndView mv = new ModelAndView("StartElectionSuccessinstate");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("electionstatusofcity","Not started");
                    return mv;
                    
               }
               else if(currentelectionadminstatus.equals("Not started"))
               {
                    query = "update admin set ElectionStatus = 'Started' where AdminId = ?";
                    pst = con.prepareStatement(query);
                    pst.setString(1, aid);
                    pst.execute();
            
//                    query = "select * from candidate where city = ? and state = ?;";
                    query = "select * from candidate where state = ?;";
                    pst = con.prepareStatement(query);
//                    pst.setString(1, citydb);
                    pst.setString(1, statedb);

                    rs = pst.executeQuery();

                    int count = 0;
                           while(rs.next())
                           {
                               count++;
//                               areadb = rs.getString("area");
//                               villagedb = rs.getString("village");
//                                wardnodb = rs.getInt("wardno");

//                               query = "select * from voter where city = ? and state = ? and wardno = ? and area = ? and village = ?";
//                               String query2 = "select * from voter where city = ? and state = ? and village = ?;";
//                               String query2 = "select * from voter where city = ? and state = ? ;";
                               String query2 = "select * from voter where state = ?;";
                               pst = con.prepareStatement(query2);
//                               pst.setString(1, citydb);
                               pst.setString(1, statedb);
//                               pst.setString(3, "");

                               ResultSet rs2 = pst.executeQuery();
                               while(rs2.next())
                               {
                                  vidfromvoter = rs2.getString("VoterID");

                                  query = "update registration set ElectionStatus = 'Started' where VoterID = ?";
                                  pst = con.prepareStatement(query);
                                  pst.setString(1, vidfromvoter);
                                  pst.execute();

                               }
                           }
                           
                        ModelAndView mv = new ModelAndView("StartElectionSuccessinstate");
                        mv.addObject("addadminmsg", addadmin);
//                        mv.addObject("count", " state = " + statedb + " city = " + citydb);
                        mv.addObject("electionstatusofcity","Started");
                        return mv;
               }
               else
               {
                        ModelAndView mv = new ModelAndView("StartElectionSuccessinstate");
                        mv.addObject("addadminmsg", addadmin);
//                        mv.addObject("electionstatusofcity","Started");
                        return mv;
               }
           }
           else
           {
                    ModelAndView mv = new ModelAndView("StartElectionSuccessinstate");
                    mv.addObject("addadminmsg", addadmin);
//                    mv.addObject("electionstatusofcity","Started");
                    return mv;
           }
           
        }
        catch(Exception e)
        {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("StartElectionSuccessinstate");
            return mv;
            
        }
        
    }
}
