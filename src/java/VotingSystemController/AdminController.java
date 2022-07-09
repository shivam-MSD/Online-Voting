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
import stdSessionController.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.BindingResult;

@Controller
@RequestMapping(value = "/HeadAdmin")
public class AdminController {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView getAdminlogin(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        ModelAndView mv = new ModelAndView("HeadAdminlogin");
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
                            ModelAndView mv = new ModelAndView("HeadAdminlogin");
                            mv.addObject("addadminmsg", addadmin);
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("error", "Incorrect password. Please enter correct password.");
                            return mv;
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                        ModelAndView mv = new ModelAndView("HeadAdminlogin");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("adminheader", "Admin Login");
                        mv.addObject("error", "password encryption error");
                        return mv;
                    }

                } else {
                    ModelAndView mv = new ModelAndView("HeadAdminlogin");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("adminheader", "Admin Login");
                    mv.addObject("formheader", "Edit Admin");
                    mv.addObject("error", "AdminId not found. Please enter correct AdminId to login.");
                    return mv;
                }
            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("HeadAdminlogin");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("adminheader", "Admin Login");
                mv.addObject("error", "connection error");
                return mv;

            }
        } else {
            ModelAndView mv = new ModelAndView("HeadAdminlogin");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("adminheader", "Admin Login");
            mv.addObject("formheader", "Admin Login");
            mv.addObject("error", "Please enter correct captcha code.");
            return mv;
        }
    }

    @RequestMapping(value = "/login/adminheaddashboard", method = RequestMethod.GET)
    public ModelAndView getAdminHeadDashboard() {
        ModelAndView mv = new ModelAndView("AdminHeaddashboard");
        mv.addObject("adminheader", "Admin Head Dashboard");
        mv.addObject("msg", "Admin Dashboard");
        return mv;
    }

    @RequestMapping(value = "/login/adminheaddashboard/addadmin", method = RequestMethod.GET)
    public ModelAndView addNewAdmin(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {
        ModelAndView mv = new ModelAndView("Addnewadmin");
        mv.addObject("adminheader", "Admin Head Dashboard");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("formheader", "Add New Admin");
        return mv;
    }

//    @RequestMapping(value = "/login/adminheaddashboard/addadmin/checkadmindetails", method = RequestMethod.POST)
    @RequestMapping(value = "/login/adminheaddashboard/addadmin", method = RequestMethod.POST)
    public ModelAndView addNewAdmincheckdetails(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        if (result.hasErrors()) {
            ModelAndView mv = new ModelAndView("Addnewadmin");
            mv.addObject("adminheader", "Admin Head Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Add New Admin");
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
                ModelAndView mv = new ModelAndView("Addnewadmin");
                mv.addObject("adminheader", "Admin Head Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Add New Admin");
                mv.addObject("error", "Admin having adminID = '" + aid + "' is already added");
                return mv;
            } else {
                query = "select * from Admin where VoterID = ?;";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                    ModelAndView mv = new ModelAndView("Addnewadmin");
                    mv.addObject("adminheader", "Admin Head Dashboard");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Add New Admin");
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

                        ModelAndView mv = new ModelAndView("Addnewadmincheckdetails");
                        mv.addObject("adminheader", "Admin Head Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Add New Admin");
                        return mv;

                    } else {
                        ModelAndView mv = new ModelAndView("Addnewadmin");
                        mv.addObject("adminheader", "Admin Head Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Add New Admin");
                        mv.addObject("error", "VoterID not found. Please enter correct VoterID.");
                        return mv;
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("Addnewadmin");
            mv.addObject("adminheader", "Admin Head Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Add New Admin");
            mv.addObject("error", "connection error");
            return mv;
        }
    }

    @RequestMapping(value = "/login/adminheaddashboard/addadminsuccess", method = RequestMethod.POST)
    public ModelAndView addNewAdminSuccess(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        String vid = addadmin.getVid().trim();
        String email = addadmin.getEmail().trim();
        String name = addadmin.getName().trim();
        String panno = addadmin.getPanno().trim();
        long aadharno = addadmin.getAadharno();
        long mobno = addadmin.getMobno();
        String statefetch = addadmin.getState().trim();

        String state[] = statefetch.split(":");
        String city = "";
        String village = "";
        String aid = addadmin.getAid().trim();

        Connection con;
        PreparedStatement pst;
        String query;

        try {
            query = "select * from admin where state = ? && city = '';";
            con = OnlinevotingDBConnection.createConnection();
            pst = con.prepareStatement(query);
            pst.setString(1, state[1]);

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
                    ModelAndView mv = new ModelAndView("Addnewadmin");
                    mv.addObject("adminheader", "Admin Head Dashboard");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Add New Admin");
                    mv.addObject("error", "Password encryption error");
                    return mv;
                }

                addadmin.setRole("Admin");
                String role = addadmin.getRole();

                try {
                    con = OnlinevotingDBConnection.createConnection();
                    query = "insert into Admin(AdminId,VoterID,Aadhar_Number,Pan_Number,Name,MobileNo,Role,password,state,email) values('" + aid + "','" + vid + "'," + aadharno + ",'" + panno + "','" + name + "'," + mobno + ",'" + role + "','" + encryptedPassword + "','" + state[1].trim() + "','" + email + "');";
                    Statement st = con.createStatement();
                    st.executeUpdate(query);

//                      m.generateAdminPassword(vid, aid, state, city, village, email, name)
//                      m.generateAdminPassword("","", "", "", "", "", "");
                    String sendEmailTo = email;
                    String subject = "Evoting Admin Selection";
                    String mailbody = "Hello " + name + ",\n\t\tYou are selected as EVoting Admin of State.Your details are display below : \nAdminID :-" + aid + "\nPassword for Admin Login :- " + password + "\nYour VoterID :- " + vid + "\nEvoting Admin of State :- " + state[1] + "\n\nIf you want to update your password, click on the link below.";

                    m.sendMailNow(sendEmailTo, subject, mailbody);
                    ModelAndView mv = new ModelAndView("AddnewadminSuccess");
                    mv.addObject("adminheader", "Admin Head Dashboard");
                    mv.addObject("msg", "Admin Dashboard");
                    return mv;
                } catch (Exception e) {
                    e.printStackTrace();
                    ModelAndView mv = new ModelAndView("Addnewadmincheckdetails");
                    mv.addObject("adminheader", "Admin Head Dashboard");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Add New Admin");
                    mv.addObject("error", "Something went wrong");
                    return mv;
                }
            } else {
                ModelAndView mv = new ModelAndView("Addnewadmincheckdetails");
                mv.addObject("adminheader", "Admin Head Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Add New Admin");
                mv.addObject("error", "You can only add one state admin per state.");
                return mv;
            }
        } catch (Exception e) {
            ModelAndView mv = new ModelAndView("Addnewadmincheckdetails");
            mv.addObject("adminheader", "Admin Head Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Add New Admin");
            mv.addObject("error", "Something went wrong");
            return mv;
        }

    }

    @RequestMapping(value = "/login/adminheaddashboard/editadmin", method = RequestMethod.GET)
    public ModelAndView editAdminform(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {
        ModelAndView mv = new ModelAndView("EditAdmin");
        mv.addObject("adminheader", "Admin Head Dashboard");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("formheader", "Edit Admin");
        mv.addObject("error", "Enter appropriate AdminID to edit admin details");
        return mv;
    }
    // checkadmindetails

//    @RequestMapping(value = "/login/adminheaddashboard/editadmin/checkadmindetails", method = RequestMethod.POST)
    @RequestMapping(value = "/login/adminheaddashboard/editadmin", method = RequestMethod.POST)
    public ModelAndView editAdminformcheckadmindetails(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

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

                    if (citydb != null) {
                        query = "select * from admin where city is null and state = ?";
                        pst = con.prepareStatement(query);
                        pst.setString(1, statedb);

                        rs = pst.executeQuery();
                        String stateadminemail;

                        if (rs.next()) {
                            stateadminemail = rs.getString("email");
                            ModelAndView mv = new ModelAndView("EditAdmin");
                            mv.addObject("adminheader", "Admin Head Dashboard");
                            mv.addObject("addadminmsg", addadmin);
                            mv.addObject("formheader", "Edit Admin");
                            mv.addObject("error", "You are not allowed to  edit subadmin details.Please send mail to state admin for updating subadmin details.\nEmailid of state admin is given below.\n" + stateadminemail);
                            mv.addObject("displayemail", stateadminemail);
                            return mv;
                        } else {
                            ModelAndView mv = new ModelAndView("EditAdmin");
                            mv.addObject("adminheader", "Admin Head Dashboard");
                            mv.addObject("addadminmsg", addadmin);
                            mv.addObject("formheader", "Edit Admin");
                            mv.addObject("error", "Sub admin is not authenticated");
//                        mv.addObject("displayemail", stateadminemail);
                            return mv;
                        }

                    } //                else if (statedb != null)
                    else if (statedb != null && citydb == null) {
                        ModelAndView mv = new ModelAndView("EditAdmincheckdetails");
                        mv.addObject("adminheader", "Admin Head Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Admin");
                        return mv;
                    } else if (statedb == null) {
                        ModelAndView mv = new ModelAndView("EditAdmincheckdetails");
                        mv.addObject("adminheader", "Admin Head Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Admin");
                        mv.addObject("error", "You are Admin Head.You are updating your own details.");
                        return mv;
                    } else {
                        ModelAndView mv = new ModelAndView("EditAdmin");
                        mv.addObject("adminheader", "Admin Head Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Admin");
                        mv.addObject("error", "Something went wrong");
                        return mv;
                    }
                } else {
                        ModelAndView mv = new ModelAndView("EditAdmin");
                        mv.addObject("adminheader", "Admin Head Dashboard");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("formheader", "Edit Admin");
                        mv.addObject("error", "Voterid of this admin is incorrect. Please enter correct voterid");
                        return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("EditAdmin");
                mv.addObject("adminheader", "Admin Head Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Edit Admin");
                mv.addObject("error", "AdminId not found. Please enter correct AdminID.");
                return mv;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditAdmin");
            mv.addObject("adminheader", "Admin Head Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Edit Admin");
            mv.addObject("error", "connection error");
            return mv;
        }

    }
//    editadminsuccess

    @RequestMapping(value = "/login/adminheaddashboard/editadmin/editadminsuccess", method = RequestMethod.POST)
    public ModelAndView editAdminformsuccss(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        String aid = addadmin.getAid().trim();
        String vid = addadmin.getVid().trim();
        String email = addadmin.getEmail();
        String name = addadmin.getName();
        String panno = addadmin.getPanno();
        long aadharno = addadmin.getAadharno();
        String state = addadmin.getState();
        long mobno = addadmin.getMobno();

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
                ModelAndView mv = new ModelAndView("EditAdmincheckdetails");
                mv.addObject("adminheader", "Admin Head Dashboard");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Edit Admin");
                mv.addObject("error", "connection error");
                return mv;
            } else {
                Mail m = new Mail();
                String sendEmailTo = email;
                String subject = "Evoting Admin details updated";
                String mailbody = "Hello " + name + ",\n\t\tYour Admin details are updated succssfully.Your details are display below : \nAdminID :- " + aid + "\nYour VoterID :- " + vid + "\nName :- " + name + "\nEvoting Admin of State :- " + state + "\nMobile No. :- " + mobno;

                m.sendMailNow(sendEmailTo, subject, mailbody);
                ModelAndView mv = new ModelAndView("EditadminSuccess");
                mv.addObject("adminheader", "Admin Head Dashboard");
                mv.addObject("msg", "Admin Dashboard");
                return mv;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditAdmincheckdetails");
            mv.addObject("adminheader", "Admin Head Dashboard");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("formheader", "Edit Admin");
            mv.addObject("error", "connection error");
            return mv;

        }

    }
//    removeadmin

    @RequestMapping(value = "/login/adminheaddashboard/removeadmin", method = RequestMethod.POST)
    public ModelAndView deleteAdminformsuccss(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {
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
    
    
    @RequestMapping(value = "/changepassword" , method = RequestMethod.GET)
    public ModelAndView changePassword(@ModelAttribute("addadminmsg") AddNewAdmin addadmin)
    {
        ModelAndView mv = new ModelAndView("AdminHeadChangePassword");
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
                            
                            ModelAndView mv = new ModelAndView("AdminHeadChangePasswordSuccess");
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("formheader", "Admin Change Password");
                            mv.addObject("addadminmsg", addadmin);
//                            mv.addObject("error","Please enter correct old password.");
                            return mv;
                        }
                        else
                        {
                            ModelAndView mv = new ModelAndView("AdminHeadChangePassword");
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("formheader", "Admin Change Password");
                            mv.addObject("error","Please enter correct old password.");
                            mv.addObject("addadminmsg", addadmin);
                            return mv;
                        }
                    }
                    else
                    {
                        ModelAndView mv = new ModelAndView("AdminHeadChangePassword");
                        mv.addObject("adminheader", "Admin Login");
                        mv.addObject("formheader", "Admin Change Password");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("error","Please enter correct confirm password.");
                        return mv;
                    }
                }
                else
                {
                    ModelAndView mv = new ModelAndView("AdminHeadChangePassword");
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
                ModelAndView mv = new ModelAndView("AdminHeadChangePassword");
                mv.addObject("adminheader", "Admin Login");
                mv.addObject("formheader", "Admin Change Password");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("error","Connection error + oldpass" + oldpassword + " newpass = " + newpassword + " newconfirmpass = " + confirmnewpassword);
                return mv;
            }
            
        }
        else
        {
            ModelAndView mv = new ModelAndView("AdminHeadChangePassword");
            mv.addObject("adminheader", "Admin Login");
            mv.addObject("formheader", "Admin Change Password");
            mv.addObject("error","Please enter correct captcha code");
            return mv;
        }
        
    }
    
    
    
    @RequestMapping(value = "/forgotpassword", method = RequestMethod.GET)
    public ModelAndView forgotPassword(@ModelAttribute("r") Registration r) {
        ModelAndView mv = new ModelAndView("HeadAdminForgotPassword");
        mv.addObject("r", r);
        mv.addObject("formheader", "Admin Change Password");
        return mv;
    }

    @RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
    public ModelAndView forgotPasswordcheckdetails(@ModelAttribute("addadminmsg") AddNewAdmin addadmin) {
        String vid = addadmin.getVid();
        String email = addadmin.getEmail();
        String newpassword = addadmin.getNewpassword();
        String confirmnewpassword = addadmin.getConfirmnewpassword();
        String captcha = addadmin.getCaptcha();
        String hiddencaptcha = addadmin.getCaptchahidden();

        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;
        if (captcha.equals(hiddencaptcha)) {
            try {
                con = OnlinevotingDBConnection.createConnection();
                query = "select * from admin where adminId = ? ;";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                        String emaildb = rs.getString("email");
                        String oldencryptedpassworddb = rs.getString("password");
                        EncryptDecryptPassword t = new EncryptDecryptPassword();
                        String olddecryptedpassword = t.decrypt(oldencryptedpassworddb);

                        if (confirmnewpassword.equals(newpassword)) {
                            //                        if(oldpassword.equals(oldencryptedpassworddb))
                            if (email.equals(emaildb)) {

                                addadmin.setEmail(email);
                                addadmin.setVid(vid);
                                addadmin.setPassword(newpassword);
                                addadmin.setConfirmpassword(newpassword);

                                Mail m = new Mail();
                                int OTP = m.generateOTP(emaildb, vid, "forgotpassword");

                                addadmin.setOTPhidden(OTP);
//                                String newencryptedpassword = t.encrypt(newpassword);
//                                query = "update registration set password = '" + newencryptedpassword + "' where voterid = '" + vid + "';";
//                                Statement st = con.createStatement();
//                                st.execute(query);

                                ModelAndView mv = new ModelAndView("HeadAdminForgotPasswordcheckdetails");
                                mv.addObject("addadminmsg", addadmin);
                                mv.addObject("formheader", "Admin Change Password");
                                return mv;
                            } else {
                                ModelAndView mv = new ModelAndView("HeadAdminForgotPassword");
                                mv.addObject("addadminmsg", addadmin);
                                mv.addObject("formheader", "Admin Change Password");
                                mv.addObject("error", "Incorrect registered emailid. Please enter correct emailid.");
                                return mv;
                            }
                        } else {
                            ModelAndView mv = new ModelAndView("HeadAdminForgotPassword");
                            mv.addObject("addadminmsg", addadmin);
                            mv.addObject("formheader", "Admin Change Password");
                            mv.addObject("error", "Please enter confirm password.");
                            return mv;
                        }
                } else {
                    ModelAndView mv = new ModelAndView("HeadAdminForgotPassword");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("formheader", "Admin Change Password");
                    mv.addObject("error", "Incorrect Adminid. Please enter correct Voterid.");
                    return mv;
                }
            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("HeadAdminForgotPassword");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("formheader", "Admin Change Password");
                mv.addObject("error", "Connection error");
                return mv;

            }

        } else {
            ModelAndView mv = new ModelAndView("HeadAdminForgotPassword");
            mv.addObject("formheader", "Admin Change Password");
            mv.addObject("error", "Please enter correct captcha code");
            mv.addObject("addadminmsg", addadmin);
            return mv;
        }

    }
    
    
    
    
    @RequestMapping(value = "/forgotpassword/successfullyupdated", method = RequestMethod.POST)
    public ModelAndView forgotPasswordSuccess(@ModelAttribute("r") Registration r) {
        String vid = r.getVid();
        String email = r.getEmail();
        String newpassword = r.getPassword();
        String confirmnewpassword = r.getConfirmpassword();
        String captcha = r.getCaptcha();
        String hiddencaptcha = r.getCaptchahidden();
        long otp = r.getOTP();
        long otphidden = r.getOTPhidden();

        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;
//        if (captcha.equals(hiddencaptcha)) {
            try {
                con = OnlinevotingDBConnection.createConnection();
                query = "select * from admin where adminId = ? ;";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                        String emaildb = rs.getString("email");
//                        String oldencryptedpassworddb = rs.getString("password");
                        EncryptDecryptPassword t = new EncryptDecryptPassword();
//                        String olddecryptedpassword = t.decrypt(oldencryptedpassworddb);

                        if (confirmnewpassword.equals(newpassword)) {
                            //                        if(oldpassword.equals(oldencryptedpassworddb))
                            if (otp == otphidden) {
                                String newencryptedpassword = t.encrypt(newpassword);
                                query = "update registration set password = '" + newencryptedpassword + "' where voterid = '" + vid + "';";
                                Statement st = con.createStatement();
                                st.execute(query);

                                ModelAndView mv = new ModelAndView("VoterForgotPasswordSuccess");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Change Password");
                                return mv;
                            } else {
                                r.setEmail(email);
                                r.setVid(vid);
                                r.setPassword(newpassword);
                                Mail m = new Mail();
                                int OTP = m.generateOTP(emaildb, vid, "forgotpassword");

                                r.setOTPhidden(OTP);
                                
                                ModelAndView mv = new ModelAndView("VoterForgotPasswordcheckdetails");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Change Password");
                                mv.addObject("error", "Incorrect verification code. Please enter correct email verification code.");
                                return mv;
                            }
                        } else {
                            ModelAndView mv = new ModelAndView("VoterForgotPasswordcheckdetails");
                            mv.addObject("r", r);
                            mv.addObject("voterloginheading", "Voter Change Password");
                            mv.addObject("error", "Please enter confirm password.");
                            return mv;
                        }
                  

                } else {
                    ModelAndView mv = new ModelAndView("VoterForgotPasswordcheckdetails");
                    mv.addObject("voterloginheading", "Voter Change Password");
                    mv.addObject("error", "Incorrect voterid. Please enter correct Voterid.");
                    return mv;
                }
            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("VoterForgotPasswordcheckdetails");
                mv.addObject("voterloginheading", "Voter Change Password");
                mv.addObject("error", "Connection error");
                return mv;

            }
//
//        } else {
//            ModelAndView mv = new ModelAndView("VoterForgotPasswordcheckdetails");
//            mv.addObject("voterloginheading", "Voter Change Password");
//            mv.addObject("error", "Please enter correct captcha code");
//            return mv;
//        }

    }
    
    
    
    
    @RequestMapping(value = "/login/adminheaddashboard/logout", method = RequestMethod.POST)
    public ModelAndView logOutCityAdmin(@ModelAttribute("addadminmsg") AddNewAdmin addadmin) {
        ModelAndView mv = new ModelAndView("HeadAdminlogout");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("adminheader", "Admin Login");
        mv.addObject("formheader", "Admin Login");
        return mv;
    }
}
