/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VotingSystemController;

import com.mysql.jdbc.UpdatableResultSet;
import java.sql.*;
import stdSessionController.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.BindingResult;

@Controller
@RequestMapping(value = "/Home")
public class OnlineVotingSystemController {

    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView getHome() {
        ModelAndView mv = new ModelAndView("Home");
        mv.addObject("mainHeader", "Dharmsinh Desai University");
        return mv;
    }

    @RequestMapping(value = "/Registration.html", method = RequestMethod.GET)
    public ModelAndView getRegistration(@ModelAttribute("Registration") Registration reg, BindingResult result) {
        String fname = reg.getFname();
        String lname = reg.getLname();
        long aadharno = reg.getAadharno();
        String panno = reg.getPanno();
        String vid = reg.getVid();
        String captcha = reg.getCaptcha();
        String captchahidden = reg.getCaptchahidden();
        Long mobno = reg.getMobno();
        String email = reg.getEmail();
        String password = reg.getPassword();
        String confirmpassword = reg.getConfirmpassword();

        if (result.hasErrors()) {
            System.out.println("fname = " + fname);
            System.out.println("lname = " + fname);
            System.out.println("aadharno = " + aadharno);
            System.out.println("panno = " + panno);
            System.out.println("vid = " + vid);
            System.out.println("captcha = " + captcha);
            System.out.println("vid = " + vid);
            System.out.println("mobno = " + mobno);
            System.out.println("password  = " + password);
            System.out.println("confirmpassword  = " + confirmpassword);
            ModelAndView model = new ModelAndView("Registration");

            model.addObject("error", "Please Enter Correct Details");
            return model;
        }

        System.out.println(" register from here.");
        ModelAndView mv = new ModelAndView("Registration");
        mv.addObject("FormHeader", "Registration Form");
        return mv;
    }

//    @RequestMapping(value = "/Registration/Regsuccess.html", method = RequestMethod.POST)
    @RequestMapping(value = "/Registration.html", method = RequestMethod.POST)
    public ModelAndView getRegistrationOtp(@ModelAttribute("Registration") Registration reg, BindingResult result) {
        String fname = reg.getFname();
        String lname = reg.getLname();
        long aadharno = reg.getAadharno();
        String panno = reg.getPanno();
        String vid = reg.getVid();
        String captcha = reg.getCaptcha();
        String captchahidden = reg.getCaptchahidden();
        Long mobno = reg.getMobno();
        String email = reg.getEmail();
        String password = reg.getPassword();
        String confirmpassword = reg.getConfirmpassword();
        String name = reg.getName();
        reg.setName(fname.trim() + " " + lname.trim());
        reg.setFname(fname.trim());
        reg.setLname(lname.trim());
        reg.setCaptcha(captcha.trim());

//        nam
        if (result.hasErrors()) {
            System.out.println("fname = " + fname);
            System.out.println("lname = " + fname);
            System.out.println("aadharno = " + aadharno);
            System.out.println("panno = " + panno);
            System.out.println("vid = " + vid);
            System.out.println("captcha = " + captcha);
            System.out.println("vid = " + vid);
            System.out.println("mobno = " + mobno);
            System.out.println("password  = " + password);
            System.out.println("confirmpassword  = " + confirmpassword);
            ModelAndView model = new ModelAndView("Registration");

            model.addObject("error", "Please Enter Correct Details");
            return model;
        }

        if (password.equals(confirmpassword)) {
            if (captcha.equals(captchahidden)) {

                Connection con;
                PreparedStatement pst;

                // Logic for verifing voter details .............................
                try {
                    con = OnlinevotingDBConnection.createConnection();
                    String query = "select * from voter where VoterID = ?;";
                    pst = con.prepareStatement(query);
                    pst.setString(1, vid);

                    ResultSet rs = pst.executeQuery();
                    
                        String viddb;
                        long aadharnodb;
                        String pannodb;
                        String namedb;
                        Long mobnodb;
                        String dobdb;
                        String addressdb;
                        String citydb;
                        String statedb;
                        String villagedb;
                        String votingzonedb;
                    

                    if (rs.next()) // check Entered voterid is correct or not 
                    // if correct then 
                    {
                        viddb = rs.getString("VoterID");
                         aadharnodb = rs.getLong("Aadhar_Number");
                         pannodb = rs.getString("Pan_Number");
                         namedb = rs.getString("Name");
                         mobnodb = rs.getLong("MobileNo");
                         dobdb = rs.getString("DOB");
                         addressdb = rs.getString("address");
                         citydb = rs.getString("city");
                         statedb = rs.getString("state");
                         villagedb = rs.getString("village");
                         votingzonedb = rs.getString("votingzone");
                        
                        query = "select * from Registration where VoterID = ? and Aadhar_Number = ? and Pan_Number = ?;";
                        pst = con.prepareStatement(query);
                        pst.setString(1, vid);
                        pst.setLong(2, aadharno);
                        pst.setString(3, panno);
                        
                        rs = pst.executeQuery();

                        if (rs.next()) //check already registered or not
                        {
                            ModelAndView mv = new ModelAndView("Registration");
                            mv.addObject("FormHeader", "Registration Details");
//                            mv.addObject("Registration", reg);
                            mv.addObject("error", "VoterID - " + vid + " has already Registered");
                            pst.close();
                            con.close();
                            return mv;
                        } 
                        else if(vid.equals(viddb) && aadharno==aadharnodb && panno.equals(pannodb))
                        {
                            if(name.equals(namedb))
                                {
                                    System.out.println("mob1 = " + mobno + " mob2 = " + mobnodb);
                                    if(mobno.equals(mobnodb))
                                    {
                                        System.out.println("mobno = " + mobnodb);
                                        reg.setVid(viddb);
                                        reg.setAadharno(aadharnodb);
                                        reg.setPanno(pannodb);
                                        reg.setName(namedb);
                                        reg.setMobno(mobnodb);
                                        reg.setDob(dobdb);
                                        reg.setAddress(addressdb);
                                        reg.setCity(citydb);
                                        reg.setState(statedb);
                                        reg.setVillage(villagedb);
                                        reg.setVotingzone(votingzonedb);

                                        ModelAndView mv = new ModelAndView("RegistrationOTP");
                                        mv.addObject("FormHeader", "Registration Details");
                                        mv.addObject("Registration", reg);
                                        mv.addObject("msg", "You will receive OTP on registered EmailID.");
                                        pst.close();
                                        con.close();
                                        return mv;
                                    }
                                    else
                                    {
                                        ModelAndView mv = new ModelAndView("Registration");
                                        mv.addObject("FormHeader", "Registration Details");
                                        mv.addObject("Registration", reg);
                                        mv.addObject("error", "Please Enter correct Mobile No. which is linked to your Aadhaar card");
                                        pst.close();
                                        con.close();
                                        return mv;
                                    }
                                }
                                else
                                {   
                                    System.out.println("mob not match ===========");
                                    ModelAndView mv = new ModelAndView("Registration");
                                    mv.addObject("FormHeader", "Registration Details");
                                    mv.addObject("Registration", reg);
                                    mv.addObject("error", "Please Enter correct Name as per Name present in your Aadhaar card");
                                    pst.close();
                                    con.close();
                                    return mv;
                                }    
                        }
                        else
                        {
                            ModelAndView mv = new ModelAndView("Registration");
                            mv.addObject("FormHeader", "Registration Details");
                            mv.addObject("Registration", reg);
                            mv.addObject("error", "Please Enter correct VoterID or Aadhaar No or Pan No.");
                            pst.close();
                            con.close();
                            return mv;
                        }
                    } 
                    else 
                    {
                        ModelAndView mv = new ModelAndView("Registration");
                        mv.addObject("FormHeader", "Registration Details");
                        mv.addObject("Registration", reg);
                        mv.addObject("error", "Please Enter correct VoterID.");
                        pst.close();
                        con.close();
                        return mv;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    ModelAndView mv = new ModelAndView("Registration");
                    mv.addObject("FormHeader", "Registration Details");
                    mv.addObject("Registration", reg);
                    mv.addObject("error", "Connection Error.");
                    return mv;
                }
            } else {
                ModelAndView mv = new ModelAndView("Registration");
                mv.addObject("FormHeader", "Registration Details");
                mv.addObject("Registration", reg);
                mv.addObject("error", "Please Enter Correct Captcha Code");
                return mv;
            }
        } else {
            ModelAndView mv = new ModelAndView("Registration");
            mv.addObject("FormHeader", "Registration Details");
            mv.addObject("Registration", reg);
            mv.addObject("error", "Please Enter Correct Confirm Password");
            return mv;
        }

    }

    @RequestMapping(value = "/RegistrationSuccessfull.html", method = RequestMethod.POST)
    public ModelAndView getRegistrationSuccess(@ModelAttribute("Registration") Registration reg, BindingResult result) {
        String fname = reg.getFname();
        String lname = reg.getLname();
        long aadharno = reg.getAadharno();
        String panno = reg.getPanno();
        String vid = reg.getVid();
        String captcha = reg.getCaptcha();
        String name = reg.getName();
        Long mobno = reg.getMobno();
        String email = reg.getEmail();
        String password = reg.getPassword();
        String confirmpassword = reg.getConfirmpassword();
        
        EncryptDecryptPassword td;
        String encryptedPassword="";
        String decryptedPassword="";
        try
        {
            td= new EncryptDecryptPassword();
            encryptedPassword = td.encrypt(password);
            decryptedPassword = td.decrypt(encryptedPassword);
        }
        catch(Exception e)
        {
            ModelAndView mv = new ModelAndView("RegistrationOTP");
            mv.addObject("FormHeader", "Registration Details");
            mv.addObject("Registration", reg);
            mv.addObject("error", "Password Encryption Error");
            mv.addObject("msg", "You will receive new OTP on registered EmailID.");
            return mv;
        }
        
        
        long otp = reg.getOTP();
        long otphidden = reg.getOTPhidden();
        if (result.hasErrors()) {
            System.out.println("fname = " + fname);
            System.out.println("lname = " + fname);
            System.out.println("aadharno = " + aadharno);
            System.out.println("panno = " + panno);
            System.out.println("vid = " + vid);
            System.out.println("captcha = " + captcha);
            System.out.println("vid = " + vid);
            System.out.println("mobno = " + mobno);
            System.out.println("password  = " + password);
            System.out.println("confirmpassword  = " + confirmpassword);
            ModelAndView model = new ModelAndView("Registration");

            model.addObject("error", "Please Enter Correct Details");
            return model;
        }

        if (otphidden == otp)
        {
            Connection con;
            PreparedStatement pst;
            String query = "";
            ResultSet rs;
            String s = "hiii";
            try
            {
                s = "1";
                    con = OnlinevotingDBConnection.createConnection();
                      query = "insert into Registration(voterId,Aadhar_Number,Pan_Number,Name,Email,password) values('" + vid + "'," + aadharno + ",'" + panno + "','" + name +"','" + email +"','" + encryptedPassword + "');";
                      Statement st = con.createStatement();
                      st.executeUpdate(query);
                      
//----------------------------------------------------------------------------------------------------                      
//                    s = "2";
//                    query = "insert into Registration(voterId,Aadhar_Number,Pan_Number,Name,Email,password) values('?',?,'?','?','?','?');";
//                    s = "3";
//                    pst = con.prepareStatement(query);
//                    s = "4";
////                    pst.setString(1, vid);
//                    pst.setString(1, reg.getVid());
//                    s = "5";
////                    pst.setLong(2, aadharno);
//                    pst.setLong(2, reg.getAadharno());
//                    
//                    s = "6";
////                    pst.setString(3, panno);
//                    pst.setString(3, reg.getPanno());
//                    s = "7";
////                    pst.setString(4, name);
//                    pst.setString(4,reg.getName());
//                    s="8";
////                    pst.setString(5, email);
//                    pst.setString(5, reg.getEmail());
//                    s="9";
//                    pst.setString(6, encryptedPassword);
//                    s = "10";
//                    rs = pst.executeQuery();
//                    s = "india...";
//----------------------------------------------------------------------------------------------------
                    ModelAndView mv = new ModelAndView("RegistrationSuccessfull");
                    mv.addObject("Registration", reg);
//                    pst.close();
                    st.close();
                    con.close();
                    return mv;
            }
            catch(Exception e)
            {
                ModelAndView mv = new ModelAndView("RegistrationOTP");
                mv.addObject("FormHeader", "Registration Details");
                mv.addObject("Registration", reg);
                mv.addObject("error", "Connection Error");
                mv.addObject("msg", "You will receive new OTP on registered EmailID. rs = " + s + " q = " + query);
                return mv;
            }
        }
        else
        {
            ModelAndView mv = new ModelAndView("RegistrationOTP");
            mv.addObject("FormHeader", "Registration Details");
            mv.addObject("Registration", reg);
            mv.addObject("error", "Please Enter Correct OTP.");
            mv.addObject("msg", "You will receive new OTP on registered EmailID.");
            return mv;
        }
    }

    @RequestMapping(value = "/Login.html", method = RequestMethod.GET)
    public ModelAndView getLogin() {
        ModelAndView mv = new ModelAndView("Login");
//        mv.addObject("mainHeader", "Dharmsinh Desai University");
        return mv;
    }

//    
//    
//    @RequestMapping(value = "/login", method = RequestMethod.GET)
//    public ModelAndView getAdminlogin() {
//        ModelAndView mv = new ModelAndView("Adminlogin");
//        mv.addObject("header", "Admin Dashboard");
//        return mv;
//    }
//    
//    @RequestMapping(value = "/login/dashboard", method = RequestMethod.GET)
//    public ModelAndView getAdminDashboard() {
//        ModelAndView mv = new ModelAndView("Adminlogin");
//        mv.addObject("header", "Admin Dashboard");
//        return mv;
//    }
    @RequestMapping(value = "/admissionForm.html", method = RequestMethod.GET)
    public ModelAndView getAdmissionForm() {
        ModelAndView mv = new ModelAndView("AdmissionForm");
        mv.addObject("mainHeader", "Dharmsinh Desai University");
        return mv;
    }

    @RequestMapping(value = "/submitAdmissionForm.html", method = RequestMethod.POST)

//    public ModelAndView submitAdmissionForm(@RequestParam("studentName")String name,@RequestParam("studentContact")String mobn,)
    // set default value when value is not entered
//    public ModelAndView submitAdmissionForm(@RequestParam(value = "studentName",defaultValue="Unknown")String name,@RequestParam(value="studentContact",defaultValue="0")String mobno)
    // handle many form fields in request using *** Map ***handler method in a controller
//    public ModelAndView submitAdmissionForm(@RequestParam Map<String,String> stdDetails)
//    public ModelAndView submitAdmissionForm(@RequestParam("studentName") String name, @RequestParam("studentContact") String mobno) 
    public ModelAndView submitAdmissionForm(@ModelAttribute("student") Student stdObj, BindingResult result) {

        if (result.hasErrors()) {
            ModelAndView model = new ModelAndView("AdmissionForm");
            return model;
        }
        // when using Map

//                    String name,mobno;
//                    name = stdDetails.get("studentName");
//                    mobno = stdDetails.get("studentContact");
        // when using Map
        //Creating Student class
//            Student student = new Student();
//            student.setStudentName(name);
//            student.setStudentContact(mobno);
        //Creating Student class
        ModelAndView mv = new ModelAndView("AdmissionSuccess");
//        mv.addObject("msg", "Your Registration is successfully done by name:- " + name + "    And Contact No. :- " + mobno);

        // Accessing each data (filled form field) individually
        // Creating Student Class
        mv.addObject("mainHeader", "Dharmsinh Desai University");

        mv.addObject("headerMsg", "Your Registration is successfully done.");
//        mv.addObject("student", student);
        // Creating Student Class
        // Accessing each data (filled form field) individually

        // Using @ModelAttribute("student")Student stdObj
//        mv.addObject("student", stdObj);
        mv.addObject("uname", stdObj.getStudentName());

        return mv;
    }

//    @ModelAttribute
//    public void addingCommonObjects(Model model) {
//        model.addAttribute("mainHeader", "Dharmsinh Desai University");
//    }
}
