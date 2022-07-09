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
@RequestMapping(value = "/Home/Voting")

public class Votingprocesscontroller {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView voterlogin(@ModelAttribute("r") Registration r) {
        ModelAndView mv = new ModelAndView("VoterLogin");
        mv.addObject("r", r);
        mv.addObject("voterloginheading", "Voter Login");
        return mv;
    }

    @RequestMapping(value = "/login/Votingdashboard", method = RequestMethod.POST)
    public ModelAndView voterdashboard(@ModelAttribute("r") Registration r) {
        String vid = r.getVid();
        String password = r.getPassword();
        String captcha = r.getCaptcha();
        String captchahidden = r.getCaptchahidden();

        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;
        String namedb;
        String statedb;
        String citydb;
        String areadb;
        String dobdb;
        String villagedb;
        int wardnodb;
        String passworddb;
        String emaildb;

        String votingstatus;

        try {

            if (captcha.equals(captchahidden)) {

                con = OnlinevotingDBConnection.createConnection();
                query = "select * from voter where VoterID = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                    statedb = rs.getString("state");
                    citydb = rs.getString("city");
                    query = "select * from registration where VoterID = ?";
                    pst = con.prepareStatement(query);
                    pst.setString(1, vid);
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        passworddb = rs.getString("password");
                        emaildb = rs.getString("email");

//                    if (captcha.equals(captchahidden)) {
                        EncryptDecryptPassword td;
                        String decryptedpassword;

                        try {
                            td = new EncryptDecryptPassword();

                            decryptedpassword = td.decrypt(passworddb);

                            if (decryptedpassword.equals(password)) {
                                votingstatus = rs.getString("status");

                                if (votingstatus.equals("Voted")) {
//                                    ModelAndView mv = new ModelAndView("VoterLogin");
                                    ModelAndView mv = new ModelAndView("VoterAlreadyVoted");
                                    mv.addObject("voterdetails", r);
                                    mv.addObject("error", "VoterID = '" + vid + "' have already voted.Please vote again on next election.");
                                    return mv;
                                } else if (votingstatus.equals("Not voted")) {
                                    String electionstatus = rs.getString("ElectionStatus");

                                    if (electionstatus.equals("Started")) {
                                        query = "select * from voter where VoterID = ?";
                                        pst = con.prepareStatement(query);
                                        pst.setString(1, vid);

                                        rs = pst.executeQuery();

                                        if (rs.next()) {

                                            vid = rs.getString("VoterID");
                                            namedb = rs.getString("name");
                                            dobdb = rs.getString("dob");
                                            citydb = rs.getString("city");
                                            statedb = rs.getString("state");
                                            villagedb = rs.getString("village");
                                            areadb = rs.getString("area");
                                            wardnodb = rs.getInt("wardno");

                                            r.setVid(vid);
                                            r.setName(namedb);
                                            r.setDob(dobdb);
                                            r.setState(statedb);
                                            r.setCity(citydb);
                                            r.setVillage(villagedb);
                                            r.setArea(areadb);
                                            r.setWardno(wardnodb);
                                            r.setEmail(emaildb);

                                            ModelAndView mv = new ModelAndView("Votersvotingdashboard");
                                            mv.addObject("r", r);
                                            mv.addObject("voterloginheading", "Voter's Give Vote");
                                            return mv;

                                        } else {
                                            ModelAndView mv = new ModelAndView("VoterLogin");
                                            mv.addObject("r", r);
                                            mv.addObject("voterloginheading", "Voter Login");
                                            mv.addObject("error", "VoterID not found. Please enter correct voterID." + votingstatus);
                                            return mv;
                                        }
                                    } else {
                                        ModelAndView mv = new ModelAndView("VoterLogin");
                                        mv.addObject("r", r);
                                        mv.addObject("voterloginheading", "Voter Login");
                                        mv.addObject("error", "Election process is not yet stated in " + citydb + ", " + statedb);
                                        return mv;
                                    }

                                } else {
                                    ModelAndView mv = new ModelAndView("VoterLogin");
                                    mv.addObject("r", r);
                                    mv.addObject("voterloginheading", "Voter Login");
                                    mv.addObject("error", "Voting status not found.");
                                    return mv;
                                }

                            } else {
                                ModelAndView mv = new ModelAndView("VoterLogin");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Login");
                                mv.addObject("error", "Incorrect password.Please enter correct password to login and vote.");
                                return mv;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            ModelAndView mv = new ModelAndView("VoterLogin");
                            mv.addObject("r", r);
                            mv.addObject("voterloginheading", "Voter Login");
                            mv.addObject("error", "Password encryption error.");
                            return mv;
                        }
//                    } 
//                    else {
//                        ModelAndView mv = new ModelAndView("VoterLogin");
//                        mv.addObject("r", r);
//                        mv.addObject("voterloginheading", "Voter Login");
//                        mv.addObject("error", "Please enter correct captcha code.");
//                        return mv;
//                    }
                    } else {
                        ModelAndView mv = new ModelAndView("VoterLogin");
                        mv.addObject("r", r);
                        mv.addObject("voterloginheading", "Voter Login");
                        mv.addObject("error", "Evoting registration not found.You have to registered for Evoting. Click on below given link to register.");
                        return mv;
                    }

                } else {
                    ModelAndView mv = new ModelAndView("VoterLogin");
                    mv.addObject("r", r);
                    mv.addObject("voterloginheading", "Voter Login");
                    mv.addObject("error", "VoterID not found. Please enter correct voterID.");
                    return mv;
                }
            } else {
                ModelAndView mv = new ModelAndView("VoterLogin");
                mv.addObject("r", r);
                mv.addObject("voterloginheading", "Voter Login");
                mv.addObject("error", "Please enter correct captcha code.");
                return mv;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("VoterLogin");
            mv.addObject("voterloginheading", "Voter Login");
            mv.addObject("error", "Error exception something went wrong.");
            mv.addObject("r", r);
            return mv;
        }

    }

    @RequestMapping(value = "/login/Votingdashboard/emailverification", method = RequestMethod.POST)
    public ModelAndView sendvoterforemailverification(@ModelAttribute("r") Registration r) {

        String vid = r.getVid();
        String name = r.getName();
        String dob = r.getDob();
        String state = r.getState();
        String city = r.getCity();
        String village = r.getVillage();
        String area = r.getArea();
        int wardno = r.getWardno();
        String email = r.getEmail();

        String candivid = r.getCandidatevid();
        String cvid[] = candivid.split(",");

//        String candidatevid = r.getCandidatevid();
        String candidatevid = cvid[0];

        String candipartyname = r.getPartyname();
        String cpartyname[] = candipartyname.split(",");

//        String partyname = r.getPartyname();
        String partyname = cpartyname[0];

        String candiname = r.getCname();
        String cname[] = candiname.split(",");

//        String candidatename = r.getCname();
        String candidatename = cname[0];

        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;
        String votingstatus;

        try {
            con = OnlinevotingDBConnection.createConnection();
            query = "select * from registration where VoterID = ?";
            pst = con.prepareStatement(query);

            pst.setString(1, vid);

            rs = pst.executeQuery();

            if (rs.next()) {
                votingstatus = rs.getString("status");
                String electionstatus = rs.getString("ElectionStatus");

                if (electionstatus.equals("Started")) {
                    if (votingstatus.equals("Voted")) {
//                        ModelAndView mv = new ModelAndView("VoterLogin");
                        ModelAndView mv = new ModelAndView("VoterAlreadyVoted");
                        mv.addObject("voterdetails", r);
                        mv.addObject("error", "VoterID = '" + vid + "' have already voted.Please vote again on next election.");
                        return mv;
                    } else {
                        r.setVid(vid);
                        r.setName(name);
                        r.setDob(dob);
                        r.setState(state);
                        r.setCity(city);
                        r.setVillage(village);
                        r.setArea(area);
                        r.setWardno(wardno);
                        r.setCandidatevid(candidatevid);
                        r.setPartyname(partyname);
                        r.setCname(candidatename);
                        r.setEmail(email);

                        Mail m = new Mail();
                        long OTP = m.generateOTP(email, vid, "voting");

                        r.setOTPhidden(OTP);

                        ModelAndView mv = new ModelAndView("Votersvotingdashboardemailverification");
                        mv.addObject("r", r);
                        mv.addObject("voterloginheading", "Voter's Verification");
                        return mv;
                    }
                } else {
                    ModelAndView mv = new ModelAndView("VoterLogin");
                    mv.addObject("r", r);
                    mv.addObject("voterloginheading", "Voter Login");
                    mv.addObject("error", "Sorry, you are late, Election processhas been ended");
                    return mv;
                }
            } else {
                ModelAndView mv = new ModelAndView("VoterLogin");
                mv.addObject("r", r);
                mv.addObject("voterloginheading", "Voter Login");
                mv.addObject("error", "VoterID not found. Please enter correct voterID.");
                return mv;
            }
        } catch (Exception e) {
            ModelAndView mv = new ModelAndView("VoterLogin");
            mv.addObject("r", r);
            mv.addObject("voterloginheading", "Voter Login");
            mv.addObject("error", "Something went wrong..");
            return mv;
        }
    }

    @RequestMapping(value = "/login/Votingdashboard/emailverification/verifying", method = RequestMethod.POST)
    public ModelAndView voterdashboardemailverification(@ModelAttribute("r") Registration r) {

        String vid = r.getVid();
        String name = r.getName();
        String dob = r.getDob();
        String state = r.getState();
        String city = r.getCity();
        String village = r.getVillage();
        String area = r.getArea();
        int wardno = r.getWardno();
        String candidatevid = r.getCandidatevid();
        String partyname = r.getPartyname();
        String candidatename = r.getCname();
        String email = r.getEmail();
        String position = r.getPartyname();

        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;

        long otp = r.getOTP();
        long otphidden = r.getOTPhidden();

        String votingstatus;
        con = OnlinevotingDBConnection.createConnection();

        try {
            query = "select * from registration where VoterID = ?";
            pst = con.prepareStatement(query);

            pst.setString(1, vid);

            rs = pst.executeQuery();

            if (rs.next()) {
                votingstatus = rs.getString("status");
                String electionstatus = rs.getString("ElectionStatus");

                if (electionstatus.equals("Started")) {
                    if (votingstatus.equals("Voted")) {
//                        ModelAndView mv = new ModelAndView("VoterLogin");
                        ModelAndView mv = new ModelAndView("VoterAlreadyVoted");
                        mv.addObject("voterdetails", r);
                        mv.addObject("error", "VoterID = '" + vid + "' have already voted.Please vote again on next election.");
                        return mv;
                    } else {
                        // if not voted part here
                        if (otp == otphidden) {
                            try {

                                query = "update registration set status = 'Voted' where VoterID = ?;";
                                pst = con.prepareStatement(query);
                                pst.setString(1, vid);

                                pst.execute();

//                query = "update candidate set votecount = votecount + 1  where VoterID = ?, party_name = ?, city = ? , state = ?;";
                                query = "update candidate set votecount = votecount + 1  where VoterID = ?;";
                                pst = con.prepareStatement(query);
                                pst.setString(1, candidatevid);
//                pst.setString(2, partyname);
//                pst.setString(3, city);
//                pst.setString(4, state);

                                pst.execute();

                                ModelAndView mv = new ModelAndView("Votingsuccessful");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Login");
                                mv.addObject("error", "Please enter correct email verification code.");
                                return mv;
                            } catch (Exception e) {
                                e.printStackTrace();
                                Mail m = new Mail();

                                long OTP = m.generateOTP(email, vid, "voting");
                                r.setOTPhidden(OTP);
                                ModelAndView mv = new ModelAndView("Votersvotingdashboardemailverification");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter's Verification");
                                mv.addObject("error", "Something went wrong.");
                                return mv;
                            }
                        } else {
                            Mail m = new Mail();
                            long OTP = m.generateOTP(email, vid, "voting");
                            r.setOTPhidden(OTP);
                            ModelAndView mv = new ModelAndView("Votersvotingdashboardemailverification");
                            mv.addObject("r", r);
                            mv.addObject("voterloginheading", "Voter's Verification");
                            mv.addObject("error", "Please enter correct email verification code.");
                            return mv;
                        }
                    }
                } else {
                    ModelAndView mv = new ModelAndView("VoterLogin");
                    mv.addObject("r", r);
                    mv.addObject("voterloginheading", "Voter Login");
                    mv.addObject("error", "Sorry, you are late, Election processhas been ended");
                    return mv;
                }

            } else {

                ModelAndView mv = new ModelAndView("VoterLogin");
                mv.addObject("r", r);
                mv.addObject("voterloginheading", "Voter Login");
                mv.addObject("error", "VoterID not found. Please enter correct voterID.");
                return mv;
            }
        } catch (Exception e) {
            ModelAndView mv = new ModelAndView("VoterLogin");
            mv.addObject("r", r);
            mv.addObject("voterloginheading", "Voter Login");
            mv.addObject("error", "Something went wrong..");
            return mv;
        }

    }

    @RequestMapping(value = "/changepassword", method = RequestMethod.GET)
    public ModelAndView changePassword(@ModelAttribute("r") Registration r) {
        ModelAndView mv = new ModelAndView("VoterChangePassword");
        mv.addObject("r", r);
        mv.addObject("voterloginheading", "Voter Change Password");
        return mv;
    }

    @RequestMapping(value = "/changepassword", method = RequestMethod.POST)
    public ModelAndView changePasswordSuccess(@ModelAttribute("r") Registration r) {
        String vid = r.getVid();
        String oldpassword = r.getOldpassword();
        String newpassword = r.getNewpassword();
        String confirmnewpassword = r.getConfirmnewpassword();
        String captcha = r.getCaptcha();
        String hiddencaptcha = r.getCaptchahidden();

        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;
        if (captcha.equals(hiddencaptcha)) {
            try {
                con = OnlinevotingDBConnection.createConnection();
                query = "select * from voter where voterId = ? ;";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                    query = "select * from registration where voterid = ? ;";
                    pst = con.prepareStatement(query);
                    pst.setString(1, vid);

                    rs = pst.executeQuery();

                    if (rs.next()) {
                        String oldencryptedpassworddb = rs.getString("password");
                        EncryptDecryptPassword t = new EncryptDecryptPassword();
                        String olddecryptedpassword = t.decrypt(oldencryptedpassworddb);

                        if (confirmnewpassword.equals(newpassword)) {
                            //                        if(oldpassword.equals(oldencryptedpassworddb))
                            if (oldpassword.equals(olddecryptedpassword)) {
                                String newencryptedpassword = t.encrypt(newpassword);
                                query = "update registration set password = '" + newencryptedpassword + "' where voterid = '" + vid + "';";
                                Statement st = con.createStatement();
                                st.execute(query);

                                ModelAndView mv = new ModelAndView("VoterChangePasswordSuccess");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Change Password");
                                return mv;
                            } else {
                                ModelAndView mv = new ModelAndView("VoterChangePassword");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Change Password");
                                mv.addObject("error", "Incorrect password. Please enter correct old password.");
                                return mv;
                            }
                        } else {
                            ModelAndView mv = new ModelAndView("VoterChangePassword");
                            mv.addObject("r", r);
                            mv.addObject("voterloginheading", "Voter Change Password");
                            mv.addObject("error", "Please enter confirm password.");
                            return mv;
                        }
                    } else {
                        ModelAndView mv = new ModelAndView("VoterChangePassword");
                        mv.addObject("voterloginheading", "Voter Change Password");
                        mv.addObject("error", "Registration not found. You have to registration to vote online.");
                        return mv;
                    }

                } else {
                    ModelAndView mv = new ModelAndView("VoterChangePassword");
                    mv.addObject("voterloginheading", "Voter Change Password");
                    mv.addObject("error", "Incorrect voterid. Please enter correct Voterid.");
                    return mv;
                }
            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("VoterChangePassword");
                mv.addObject("voterloginheading", "Voter Change Password");
                mv.addObject("error", "Connection error");
                return mv;

            }

        } else {
            ModelAndView mv = new ModelAndView("VoterChangePassword");
            mv.addObject("voterloginheading", "Voter Change Password");
            mv.addObject("error", "Please enter correct captcha code");
            return mv;
        }

    }

    @RequestMapping(value = "/forgotpassword", method = RequestMethod.GET)
    public ModelAndView forgotPassword(@ModelAttribute("r") Registration r) {
        ModelAndView mv = new ModelAndView("VoterForgotPassword");
        mv.addObject("r", r);
        mv.addObject("voterloginheading", "Voter Change Password");
        return mv;
    }

    @RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
    public ModelAndView forgotPasswordcheckdetails(@ModelAttribute("r") Registration r) {
        String vid = r.getVid();
        String email = r.getEmail();
        String newpassword = r.getNewpassword();
        String confirmnewpassword = r.getConfirmnewpassword();
        String captcha = r.getCaptcha();
        String hiddencaptcha = r.getCaptchahidden();

        Connection con;
        PreparedStatement pst;
        String query;
        ResultSet rs;
        if (captcha.equals(hiddencaptcha)) {
            try {
                con = OnlinevotingDBConnection.createConnection();
                query = "select * from voter where voterId = ? ;";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                    query = "select * from registration where voterid = ? ;";
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

                                r.setEmail(email);
                                r.setVid(vid);
                                r.setPassword(newpassword);
                                r.setConfirmpassword(newpassword);

                                Mail m = new Mail();
                                int OTP = m.generateOTP(emaildb, vid, "forgotpassword");

                                r.setOTPhidden(OTP);
//                                String newencryptedpassword = t.encrypt(newpassword);
//                                query = "update registration set password = '" + newencryptedpassword + "' where voterid = '" + vid + "';";
//                                Statement st = con.createStatement();
//                                st.execute(query);

                                ModelAndView mv = new ModelAndView("VoterForgotPasswordcheckdetails");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Change Password");
                                return mv;
                            } else {
                                ModelAndView mv = new ModelAndView("VoterForgotPassword");
                                mv.addObject("r", r);
                                mv.addObject("voterloginheading", "Voter Change Password");
                                mv.addObject("error", "Incorrect registered emailid. Please enter correct emailid.");
                                return mv;
                            }
                        } else {
                            ModelAndView mv = new ModelAndView("VoterForgotPassword");
                            mv.addObject("r", r);
                            mv.addObject("voterloginheading", "Voter Change Password");
                            mv.addObject("error", "Please enter confirm password.");
                            return mv;
                        }
                    } else {
                        ModelAndView mv = new ModelAndView("VoterForgotPassword");
                        mv.addObject("voterloginheading", "Voter Change Password");
                        mv.addObject("error", "Registration not found. You have to registration to vote online.");
                        return mv;
                    }

                } else {
                    ModelAndView mv = new ModelAndView("VoterForgotPassword");
                    mv.addObject("voterloginheading", "Voter Change Password");
                    mv.addObject("error", "Incorrect voterid. Please enter correct Voterid.");
                    return mv;
                }
            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("VoterForgotPassword");
                mv.addObject("voterloginheading", "Voter Change Password");
                mv.addObject("error", "Connection error");
                return mv;

            }

        } else {
            ModelAndView mv = new ModelAndView("VoterForgotPassword");
            mv.addObject("voterloginheading", "Voter Change Password");
            mv.addObject("error", "Please enter correct captcha code");
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
                query = "select * from voter where voterId = ? ;";
                pst = con.prepareStatement(query);
                pst.setString(1, vid);

                rs = pst.executeQuery();

                if (rs.next()) {
                    query = "select * from registration where voterid = ? ;";
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
                        mv.addObject("error", "Registration not found. You have to registration to vote online.");
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
}
