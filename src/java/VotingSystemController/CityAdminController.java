package VotingSystemController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import stdSessionController.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.BindingResult;
import java.util.Calendar;
import java.time.*;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping(value = "/Subadmin")
public class CityAdminController {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView getAdminlogin(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result) {

        ModelAndView mv = new ModelAndView("CityAdminlogin");
        mv.addObject("addadminmsg", addadmin);
        mv.addObject("adminheader", "Admin Login");
        mv.addObject("formheader", "Admin Login");
        return mv;
    }
    
    
    
    @RequestMapping(value = "/login", method = RequestMethod.POST)
//    public ModelAndView getAdminloginsuccess(@ModelAttribute("addadminmsg") AddNewAdmin addadmin, BindingResult result,HttpServletRequest request,HttpServletResponse response) {
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
                                
//                                HttpServletRequest request;
//                                request.setAttribute("citysessionname", citydb);
                                ModelAndView mv = new ModelAndView("CityAdminloginsuccess");
                                mv.addObject("addadminmsg", addadmin);
                                mv.addObject("adminheader", "Admin Login");
                                return mv;
                            }

                        } else {
                            ModelAndView mv = new ModelAndView("CityAdminlogin");
                            mv.addObject("addadminmsg", addadmin);
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("error", "Incorrect password. Please enter correct password.");
                            return mv;
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                        ModelAndView mv = new ModelAndView("CityAdminlogin");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("adminheader", "Admin Login");
                        mv.addObject("error", "password encryption error");
                        return mv;
                    }

                } else {
                    ModelAndView mv = new ModelAndView("CityAdminlogin");
                    mv.addObject("addadminmsg", addadmin);
                    mv.addObject("adminheader", "Admin Login");
                    mv.addObject("formheader", "Admin Login");
                    mv.addObject("error", "AdminId not found. Please enter correct AdminId to login.");
                    return mv;
                }
            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("CityAdminlogin");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("adminheader", "Admin Login");
                mv.addObject("error", "connection error");
                return mv;

            }
        } else {
            ModelAndView mv = new ModelAndView("CityAdminlogin");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("adminheader", "Admin Login");
            mv.addObject("formheader", "Admin Login");
            mv.addObject("error", "Please enter correct captcha code.");
            return mv;
        }
    }
    
    
    
    
    
    @RequestMapping(value = "/login/subadmindashboard", method = RequestMethod.GET)
    public ModelAndView getAdminHeadDashboard() {
        ModelAndView mv = new ModelAndView("CityAdminDashboard");
        mv.addObject("adminheader", "Subadmin Dashboard");
        return mv;
    }

    // add candidate
    @RequestMapping(value = "/login/subadmindashboard/addcitycandidate", method = RequestMethod.GET)
    public ModelAndView addNewcityCandidate(@ModelAttribute("candidate") Candidate candidate) {
        ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
        mv.addObject("adminheader", "Subadmin Dashboard");
        mv.addObject("candi", candidate);
        mv.addObject("formheader", "Add Candidate");
//        mv.addObject("error", "connection error");
        return mv;
    }

    @RequestMapping(value = "/login/subadmindashboard/addcitycandidate", method = RequestMethod.POST)
    public ModelAndView addNewcityCandidatecheckdetails(@ModelAttribute("candidate") Candidate candidate) {
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
                    ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
                    mv.addObject("adminheader", "Subadmin Dashboard");
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

                    if (position.equals("Mayor")) {
                        ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmincheckdetails");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Add Candidate");
                        mv.addObject("error", "Verify all details of candidate and fill all other remaining details.");
                        return mv;
                    } else if (position.equals("Sarpanch")) {
                        ModelAndView mv = new ModelAndView("Addcityvillagecandidatebysubadmincheckdetails");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Add Candidate");
                        mv.addObject("error", "Verify all details of candidate and fill all other remaining details.");
                        return mv;
                    } else {
                        ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Add Candidate");
                        mv.addObject("error", "Something went wrong.");
                        return mv;
                    }
                }

            } else {
                ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
                mv.addObject("adminheader", "Subadmin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Add Candidate");
                mv.addObject("error", "Voterid not found. Please enter correct voterid.");
                return mv;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
            mv.addObject("adminheader", "Subadmin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Add Candidate");
            mv.addObject("error", "connection error");
            return mv;
        }

    }

    // addcandidatesuccess
    @RequestMapping(value = "login/subadmindashboard/addcitycandidatesuccess", method = RequestMethod.POST)
    public ModelAndView addNewStateCandidatesuccess(@ModelAttribute("candidate") Candidate candidate) {
        Connection con;
        PreparedStatement pst;
        ResultSet rs;

        String position = candidate.getPosition();

        String vid;
        String cname;
        String panno;

//        Blob partylogo;
        String partylogo;
        long aadharno;
        String area;
        int wardno;
        String statefetch;
        String city;
        String partyname;
        String village;
        String municorpo;

        String query;

        if (position.equals("Sarpanch")) {
            vid = candidate.getVid();
            cname = candidate.getCname();
            panno = candidate.getPanno();
            partylogo = candidate.getPartylogo();
            aadharno = candidate.getAadharno();
            statefetch = candidate.getState();
            String statearr[] = statefetch.split(":");
            String state = statearr[1];
            city = candidate.getCity();
            partyname = candidate.getPartyname();
            wardno = candidate.getWardno();
            village = candidate.getVillage();
            municorpo = candidate.getMunicorpo();

            query = "select * from candidate where state = ? and city = ? and village = ? and party_name = ? and wardno = ?";

            try {
                con = OnlinevotingDBConnection.createConnection();
                pst = con.prepareStatement(query);
                pst.setString(1, state);
                pst.setString(2, city);
                pst.setString(3, village);
                pst.setString(4, partyname);
                pst.setInt(5, wardno);

                rs = pst.executeQuery();

                int count = 0;
                while (rs.next()) {
                    count = count + 1;
                }

                if (count >= 1) {

                    ModelAndView mv = new ModelAndView("Addcityvillagecandidatebysubadmincheckdetails");
                    mv.addObject("adminheader", "Subadmin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Add Candidate");
                    mv.addObject("error", "You can only add one candidate of each party in particular state, city and area..");
                    return mv;
                } else {
                    query = "insert into candidate(VoterID,candidate_name,party_name,position,party_logo,state,city,village,wardno) values('" + vid + "','" + cname + "','" + partyname + "','" + position + "','" + partylogo + "','" + state + "','" + city + "','" + village + "'," + wardno + ");";
                    Statement st = con.createStatement();
                    st.executeUpdate(query);

                    ModelAndView mv = new ModelAndView("Addcitycandidatebysubadminsuccess");
                    mv.addObject("adminheader", "Subadmin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Add Candidate");
//                    mv.addObject("error", "You can only add one candidate of each party in particular state, city and area..");
                    return mv;
                }

            } catch (Exception e) {
                ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
                mv.addObject("adminheader", "Subadmin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Add Candidate");
                mv.addObject("error", "Something went wrong in sarpanch state = " + state + "statefetch = " + statefetch + "city = " + city);
                return mv;
            }

        } else if (position.equals("Mayor")) {
            vid = candidate.getVid();
            cname = candidate.getCname();
            panno = candidate.getPanno();
            partylogo = candidate.getPartylogo();
            aadharno = candidate.getAadharno();
            statefetch = candidate.getState();
            String statearr[] = statefetch.split(":");
            String state = statearr[1];
            city = candidate.getCity();
            partyname = candidate.getPartyname();
            wardno = candidate.getWardno();
            area = candidate.getArea();
            municorpo = candidate.getMunicorpo();

            query = "select * from candidate where state = ? and city = ? and area = ? and party_name = ? and wardno = ?";

            try {
                con = OnlinevotingDBConnection.createConnection();
                pst = con.prepareStatement(query);
                pst.setString(1, state);
                pst.setString(2, city);
                pst.setString(3, area);
                pst.setString(4, partyname);
                pst.setInt(5, wardno);

                rs = pst.executeQuery();

                int count = 0;
                while (rs.next()) {
                    count = count + 1;
                }

                if (count == 0) {
                    query = "insert into candidate(VoterID,candidate_name,party_name,position,party_logo,state,city,area,wardno,village) values('" + vid + "','" + cname + "','" + partyname + "','" + position + "','" + partylogo + "','" + state + "','" + city + "','" + area + "'," + wardno + ",'');";
                    Statement st = con.createStatement();
                    st.executeUpdate(query);

                    ModelAndView mv = new ModelAndView("Addcitycandidatebysubadminsuccess");
                    mv.addObject("adminheader", "Subadmin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Add Candidate");
//                    mv.addObject("error", "You can only add one candidate of each party in particular state, city and area..");
                    return mv;
                } else {
                    ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmincheckdetails");
                    mv.addObject("adminheader", "Subadmin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Add Candidate");
                    mv.addObject("error", "You can only add one candidate of each party in particular state, city and area..");
                    return mv;
                }

            } catch (Exception e) {
                e.printStackTrace();
                ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
                mv.addObject("adminheader", "Subadmin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Add Candidate");
                mv.addObject("error", "Something went wrong in mayor");
                return mv;
            }

        } else {
            ModelAndView mv = new ModelAndView("Addcitycandidatebysubadmin");
            mv.addObject("adminheader", "Subadmin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Add Candidate");
            mv.addObject("error", "Something went wrong");
            return mv;
        }
    }

    // Edit candidate details
    @RequestMapping(value = "/login/subadmindashboard/editcitycandidate", method = RequestMethod.GET)
    public ModelAndView editStateCandidate(@ModelAttribute("candidate") Candidate candidate) {
        ModelAndView mv = new ModelAndView("EditCityCandidatebysubadmin");
        mv.addObject("adminheader", "Subadmin Dashboard");
        mv.addObject("candi", candidate);
        mv.addObject("formheader", "Edit Candidate");
        mv.addObject("error", "");
        return mv;
    }

    @RequestMapping(value = "/login/subadmindashboard/editcitycandidate", method = RequestMethod.POST)
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
//            and (position ='MLA' or position = 'MP')
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
            String villagedb;
            String areadb;
            int wardno;

            if (rs.next()) {
                positiondb = rs.getString("position");

//                if((positiondb.equals('MLA')) || (positiondb.equals('MP')))
                if (position.equals("Mayor") || position.equals("Sarpanch")) {
                    viddb = rs.getString("VoterID");
                    partynamedb = rs.getString("party_name");
                    positiondb = rs.getString("position");
                    cnamedb = rs.getString("candidate_name");
                    statedb = rs.getString("state");
                    citydb = rs.getString("city");
//                partylogodb = rs.getBlob("party_logo");
                    partylogodb = rs.getString("party_logo");
                    areadb = rs.getString("area");
                    villagedb = rs.getString("village");
                    wardno = rs.getInt("wardno");

                    candidate.setVid(vid);
                    candidate.setPartyname(partyname);
                    candidate.setPartylogo(partylogodb);
                    candidate.setCname(cnamedb);
                    candidate.setState(statedb);
                    candidate.setCity(citydb);
                    candidate.setPosition(position);
                    candidate.setVillage(villagedb);
                    candidate.setWardno(wardno);
                    candidate.setArea(areadb);

                    if (position.equals("Mayor")) {
                        ModelAndView mv = new ModelAndView("EditCityCandidatebysubadmincheckdetails");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Edit Candidate");
                        mv.addObject("error", "Verify all details of candidate and update the fields which you want to update.");
                        return mv;
                    } else if (position.equals("Sarpanch")) {
                        ModelAndView mv = new ModelAndView("EditCityVillageCandidatebysubadmincheckdetails");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Edit Candidate");
                        mv.addObject("error", "Verify all details of candidate and update the fields which you want to update.");
                        return mv;
                    } else {
                        ModelAndView mv = new ModelAndView("EditCityCandidatebysubadmin");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Edit Candidate");
                        mv.addObject("error", "Something went wrong.");
                        return mv;
                    }

                } else {
                    ModelAndView mv = new ModelAndView("EditCityCandidatebysubadmin");
                    mv.addObject("adminheader", "Subadmin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Edit Candidate");
                    mv.addObject("error", "You can only edit city candidate details.");
                    return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("EditCityCandidatebysubadmin");
                mv.addObject("adminheader", "Subadmin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Edit Candidate");
                mv.addObject("error", "Candidate of Voterid = '" + vid + "' is not found. Please enter correct voterid.");
                return mv;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditCityCandidatebysubadmin");
            mv.addObject("adminheader", "Subadmin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Edit Candidate");
            mv.addObject("error", "connection error");
            return mv;
        }
    }

    // editcandidatesuccess
    @RequestMapping(value = "/login/subadmindashboard/editcitycandidatesuccess", method = RequestMethod.POST)
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
        String village = candidate.getVillage();
        String area = candidate.getArea();
        int wardno = candidate.getWardno();

        if (village == null) {
            village = "";
        }
        if (area == null) {
            area = "";
        }

        String query = "select * from candidate where state = ? and city = ? and party_name = ? and (area is null or village = ?) and wardno = ?;";
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

                query = "update candidate set party_name = '" + partyname + "' , position = '" + position + "' , party_logo = '" + partylogo + "' , state = '" + state + "' , city = '" + city + "' , area = '" + area + "', village = '" + village + "', wardno = " + wardno + " where VoterID = '" + vid + "' ;";
                Statement st = con.createStatement();

//                boolean ans = pst.execute();
                boolean ans = st.execute(query);

                if (ans) {
                    if (position.equals("Mayor")) {
                        ModelAndView mv = new ModelAndView("EditCityCandidatebysubadmincheckdetails");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Edit Candidate");
                        mv.addObject("error", "Error in updating candidate details.Please check all the details.");
                        return mv;
                    } else {
                        ModelAndView mv = new ModelAndView("EditCityVillageCandidatebysubadmincheckdetails");
                        mv.addObject("adminheader", "Subadmin Dashboard");
                        mv.addObject("candidate", candidate);
                        mv.addObject("formheader", "Edit Candidate");
                        mv.addObject("error", "Error in updating candidate details.Please check all the details.");
                        return mv;
                    }

                    
                } else {
                    ModelAndView mv = new ModelAndView("EditCityCandidatebysubadminsuccess");
                    mv.addObject("adminheader", "Subadmin Dashboard");
                    mv.addObject("candidate", candidate);
                    mv.addObject("formheader", "Edit Candidate");
//                mv.addObject("error", "You can only add one candidate of any party. Please select correct city and state.");
                    return mv;
                }

            } else {
                ModelAndView mv = new ModelAndView("EditCandidatebyadmincheckdetails");
                mv.addObject("adminheader", "Subadmin Dashboard");
                mv.addObject("candidate", candidate);
                mv.addObject("formheader", "Edit Candidate");
                mv.addObject("error", "You can only add one candidate of any party. Please select correct city and state.");
                return mv;

            }
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("EditCandidatebyadmincheckdetails");
            mv.addObject("adminheader", "Subadmin Dashboard");
            mv.addObject("candidate", candidate);
            mv.addObject("formheader", "Edit Candidate");
            mv.addObject("error", "Connnection error.");
            return mv;
        }
    }

    // delete candidate details
    @RequestMapping(value = "/login/subadmindashboard/removecitycandidate", method = RequestMethod.POST)
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

            String query = "delete from candidate where VoterID = '" + vid + "';";
            Statement st = con.createStatement();

            int ans = st.executeUpdate(query);
            if (ans != 0) {
                ModelAndView mv = new ModelAndView("RemoveCityCanditatebysubadminsuccess");
                mv.addObject("candidate", candidate);
                mv.addObject("adminheader", "Subadmin Dashboard");
                mv.addObject("msg", "Admin Dashboard");
                return mv;
            } else {
                ModelAndView mv = new ModelAndView("RemoveCityCanditatebysubadminsuccess");
                mv.addObject("candidate", candidate);
                mv.addObject("adminheader", "Subadmin Dashboard");
                mv.addObject("msg", "Admin Dashboard");
                return mv;
            }

        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("RemoveCityCanditatebysubadminsuccess");
            mv.addObject("candidate", candidate);
            mv.addObject("adminheader", "Subadmin Dashboard");
            mv.addObject("msg", "Admin Dashboard");
            return mv;
        }
    }
    
    
//    startelectionprocessincity
    @RequestMapping(value = "/login/subadmindashboard/startelectionprocessincity", method = RequestMethod.POST)
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
               citydb = rs.getString("city");
               currentelectionadminstatus = rs.getString("ElectionStatus");
               
               if(currentelectionadminstatus.equals("Started"))
               {
                    query = "update admin set ElectionStatus = 'Not started' where AdminId = ?";
                    pst = con.prepareStatement(query);
                    pst.setString(1, aid);
                    pst.execute();


                    Year y = Year.now();


                   java.util.Date date = Calendar.getInstance().getTime();  
                   DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
                   String strDate = dateFormat.format(date);  

//                    String year = y.format(DateTimeFormatter.ofLocalizedDate(y.MEDIUM));
                    query = "select * from candidate where wardno != 0 and (village != '' or area != '') and state = ? and city = ?;";
                    
                    pst = con.prepareStatement(query);
                    pst.setString(1, statedb);
                    pst.setString(2, citydb);
                    
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
                        
                        
//                        String query2 = "insert into electionresult values(" + YearOfElection + ",'" + vidofcandidatedb + "','"+ cnamedb + "','" + partynamedb +"','" + positiondb + "','" + partylogodb + "','" + statedb + "','" + citydb + "','" + villagedb + "'," + wardnodb + ",'" + areadb + "'," + votecount +  ")";

                        String query2 = "insert into electionresult values(" + y + ",'" + vidofcandidatedb + "','"+ cnamedb + "','" + partynamedb +"','" + positiondb + "','" + partylogodb + "','" + statedb + "','" + citydb + "','" + villagedb + "'," + wardnodb + ",'" + areadb + "'," + votecount +  ")";
                        Statement st = con.createStatement();
                        st.execute(query2);
                        
                        query2 = "delete from candidate where VoterID = ?";
                        pst = con.prepareStatement(query2);
                        pst.setString(1, vidofcandidatedb);
                        pst.execute();
                        
                            String query3 = "select * from voter where city = ? and state = ? and wardno = ?;";
                            pst = con.prepareStatement(query3);
                            pst.setString(1, citydb);
                            pst.setString(2, statedb);
                            pst.setInt(3,wardnodb);

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
                    ModelAndView mv = new ModelAndView("StartElectionSuccessincity");
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
            
                    query = "select * from candidate where city = ? and state = ?;";
                    pst = con.prepareStatement(query);
                    pst.setString(1, citydb);
                    pst.setString(2, statedb);

                    rs = pst.executeQuery();

                           while(rs.next())
                           {
                               areadb = rs.getString("area");
                               villagedb = rs.getString("village");
                                wardnodb = rs.getInt("wardno");

//                               query = "select * from voter where city = ? and state = ? and wardno = ? and area = ? and village = ?";
                               String query2 = "select * from voter where city = ? and state = ? and wardno = ?;";
                               pst = con.prepareStatement(query2);
                               pst.setString(1, citydb);
                               pst.setString(2, statedb);
                               pst.setInt(3, wardnodb);

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
                           
                        ModelAndView mv = new ModelAndView("StartElectionSuccessincity");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("electionstatusofcity","Started");
                        return mv;
               }
               else
               {
                        ModelAndView mv = new ModelAndView("StartElectionSuccessincity");
                        mv.addObject("addadminmsg", addadmin);
//                        mv.addObject("electionstatusofcity","Started");
                        return mv;
               }
           }
           else
           {
                    ModelAndView mv = new ModelAndView("StartElectionSuccessincity");
                    mv.addObject("addadminmsg", addadmin);
//                    mv.addObject("electionstatusofcity","Started");
                    return mv;
           }
           
        }
        catch(Exception e)
        {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("StartElectionSuccessincity");
            return mv;
            
        }
        
    }
    
    
    
//CityAdminLogout
    @RequestMapping(value = "/login/subadmindashboard/logout", method = RequestMethod.POST)
    public ModelAndView logOutCityAdmin(@ModelAttribute("addadminmsg")  AddNewAdmin addadmin) {
         ModelAndView mv = new ModelAndView("CityAdminLogout");
            mv.addObject("addadminmsg", addadmin);
            mv.addObject("adminheader", "Admin Login");
            mv.addObject("formheader", "Admin Login");
            mv.addObject("error", "Please enter correct captcha code.");
            return mv;
    }
    
    
    @RequestMapping(value = "/changepassword" , method = RequestMethod.GET)
    public ModelAndView changePassword(@ModelAttribute("addadminmsg") AddNewAdmin addadmin)
    {
        ModelAndView mv = new ModelAndView("CityAdminChangePassword");
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
                            
                            ModelAndView mv = new ModelAndView("CityAdminChangePasswordSuccess");
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("formheader", "Admin Change Password");
                            mv.addObject("addadminmsg", addadmin);
//                            mv.addObject("error","Please enter correct old password.");
                            return mv;
                        }
                        else
                        {
                            ModelAndView mv = new ModelAndView("CityAdminChangePassword");
                            mv.addObject("adminheader", "Admin Login");
                            mv.addObject("formheader", "Admin Change Password");
                            mv.addObject("error","Please enter correct old password.");
                            mv.addObject("addadminmsg", addadmin);
                            return mv;
                        }
                    }
                    else
                    {
                        ModelAndView mv = new ModelAndView("CityAdminChangePassword");
                        mv.addObject("adminheader", "Admin Login");
                        mv.addObject("formheader", "Admin Change Password");
                        mv.addObject("addadminmsg", addadmin);
                        mv.addObject("error","Please enter correct confirm password.");
                        return mv;
                    }
                }
                else
                {
                    ModelAndView mv = new ModelAndView("CityAdminChangePassword");
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
                ModelAndView mv = new ModelAndView("CityAdminChangePassword");
                mv.addObject("adminheader", "Admin Login");
                mv.addObject("formheader", "Admin Change Password");
                mv.addObject("addadminmsg", addadmin);
                mv.addObject("error","Connection error + oldpass" + oldpassword + " newpass = " + newpassword + " newconfirmpass = " + confirmnewpassword);
                return mv;
            }
            
        }
        else
        {
            ModelAndView mv = new ModelAndView("CityAdminChangePassword");
            mv.addObject("adminheader", "Admin Login");
            mv.addObject("formheader", "Admin Change Password");
            mv.addObject("error","Please enter correct captcha code");
            return mv;
        }
        
    }
}
