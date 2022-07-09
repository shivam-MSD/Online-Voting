<%-- 
    Document   : Regsuccess
    Created on : 10 May, 2022, 5:39:25 PM
    Author     : Admin
--%>
<%@page import="javax.mail.internet.MimeMultipart"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Registration Details</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="<c:url value='/resources/css/Form_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/Header_CSS.css' />" rel="stylesheet">
    </head>


    <%! String sendEmailTo;
            String vid;%>

    <%
        sendEmailTo = request.getParameter("email");
        vid = request.getParameter("vid");
    %>
    <%!
        Session newSession = null;
        MimeMessage mimeMessage;
        int otp = sendOtp();

        public int sendOtp() {
            setupServerProperties();
            draftEmail();
            otp = sendMail();

            return otp;
        }

        private void setupServerProperties() {
            Properties p = System.getProperties();
            p.put("mail.smtp.port", "587");
            p.put("mail.smtp.auth", "true");
            p.setProperty("mail.smtp.starttls.enable", "true");
            p.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
            newSession = Session.getDefaultInstance(p, null);

        }

        private MimeMessage draftEmail() {
            String from = "shivapatel1102001@gmail.com";
            String subject = "Evoting Registration OTP";
            String body = "Evoting Registration OTP";
            mimeMessage = new MimeMessage(newSession);

            try {
                mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(sendEmailTo));
                mimeMessage.setSubject(subject);
                MimeMultipart multipart = new MimeMultipart();
                MimeBodyPart bodyPart = new MimeBodyPart();
                bodyPart.setContent(body, "text/plain");
//            bodyPart.setContent(body, "html/text");
                MimeMultipart multiPart = new MimeMultipart();
                multiPart.addBodyPart(bodyPart);
                mimeMessage.setContent(multiPart);
                return mimeMessage;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        private int sendMail() {
            String fromUser = "shivapatel1102001@gmail.com";

            String userPassword = "mdgbfgicunisbbcg";

            String emailHost = "smtp.gmail.com";

            try {

                Random r = new Random();
                int low = 100000;
                int high = 999999;
                int x = r.nextInt(high - low) + low;
                String.format("%06d", x);
                mimeMessage.setText("Dear voter,\n\t VoterId :- " + vid + "\n\tEmail verification code for Evoting Registration is " + Integer.parseInt(String.format("%06d", x)));

                Transport tp = newSession.getTransport("smtp");
                System.out.println("Establising connection... 1");
                tp.connect(emailHost, fromUser, userPassword);
                System.out.println("Establising connection...2");
                tp.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
                System.out.println("Establising connection...");
                tp.close();
                System.out.println("Email successfully Send");
                return x;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 0;
        }

    %>




    <!--<body onload="">-->
    <body onload="loadpage()" oncontextmenu="return false;">
        <%@include file="Header.jsp" %>

        <div class="container">
            <!--<form  class="form" action="/Home/Registration/Regsuccess.html" method="post" style="background-image: url('evote1.jpg')">-->
            <form  class="form" style="background-image: url('evote1.jpg')" action="RegistrationSuccessfull.html" method="post">

                <div class="regformheading">
                    <center><u><h3>${FormHeader}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error} ${msg}</h5>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="vidid">Voter ID</label>
                        <input type="text" class="form-control" placeholder="VoterID" name="vid" value="${Registration.vid}" id="vidid" readonly>
                    </div>

                    <div class="form-group col-md-6">        
                        <label for="fnameid">Name</label>
                        <input type="text" class="form-control" placeholder="First name" name="name" id="nameid" value='${Registration.name}' readonly>
                    </div>
                    <div class="form-group col-md-6" hidden>        
                        <label for="fnameid">First Name</label>
                        <input type="text" class="form-control" placeholder="First name" name="fname" id="fnameid" value='${Registration.fname}' readonly>
                    </div>
                    <div class="form-group col-md-6" >        
                        <label for="emailid">Email ID</label>
                        <input type="email" class="form-control" placeholder="Email id" name="email"value="${Registration.email}" id="emailid" readonly>
                    </div>
                    <div class="form-group col-md-6" hidden>        
                        <label for="lnameid">Last name</label>
                        <input type="text" class="form-control" placeholder="Last name"name="lname" id="lnameid" value="${Registration.lname}" readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="mobnoid">Mobile No</label>
                        <input type="number" class="form-control" placeholder="Mobile No registered in aadharcard" name="mobno" value="${Registration.mobno}" id="mobnoid" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="aadharno">Aadhaar Number</label>
                        <input type="number" class="form-control" placeholder="Aadharcard Number" name="aadharno" value="${Registration.aadharno}" id="aadharno" readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="pannoid">Pan Number</label>
                        <input type="text" class="form-control" placeholder="Pan Number" name="panno" value="${Registration.panno}" id="pannoid" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <!--                    <div class="form-group col-md-6">        
                                            <label for="vidid">Voter ID</label>
                                            <input type="text" class="form-control" placeholder="VoterID" name="vid" value="${Registration.vid}" id="vidid" readonly>
                                        </div>-->
                    <div class="form-group col-md-6">        
                        <label for="dobid">Date Of Birth</label>
                        <input type="text" class="form-control" placeholder="dob" name="dob" value="${Registration.dob}" id="dobid" readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="lnameid">Address</label>
                        <input type="text" class="form-control" placeholder="address"name="address" id="addressid" value="${Registration.address}" readonly>
                    </div>
                </div>
                <div class="form-row" hidden="true">
                    <div class="form-group col-md-6" hidden="true">        
                        <label for="passwordid">Password</label>
                        <input type="password" class="form-control" placeholder="Create Password" name="password"value="${Registration.password}"  id="passwordid" readonly hidden="true">
                    </div>
                    <div class="form-group col-md-6" hidden="true">        
                        <label for="confirmpasswordid">Confirm Password</label>
                        <input type="password" class="form-control" placeholder="Confirm Password" name="confirmpassword" value="${Registration.confirmpassword}" id="confirmpasswordid" readonly hidden="true">
                    </div>
                </div> 
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="state">State</label>
                        <input type="text" class="form-control" placeholder="State" name="state" value="${Registration.state}" id="stateid" readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="cityid">City</label>
                        <input type="text" class="form-control" placeholder="city" name="city" value="${Registration.city}" id="cityid" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="villageid">Village</label>
                        <input type="text" class="form-control" placeholder="" name="village" value="${Registration.village}" id="villageid" readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="votingzoneid">Assembly Constituency No And Name(Voting Zone)</label>
                        <input type="text" class="form-control" placeholder="" name="votingzone" value="${Registration.votingzone}" id="votingzoneid" readonly>
                    </div>
                </div>   
                <div class="form-group col-md-6" hidden="true">        
                    <label for="captcha">Captcha</label>
                    <input type="number" class="form-control" name="captcha" value="${Registration.captcha}" id="captchaid" readonly>
                </div>

                <center>
                    <div class="form-group col-md-12">        
                        <label for="OTP">Enter Email Verification Code(OTP)</label>
                        <input type="number" class="form-control col-md-2" name="OTP" id="OTPid" min="100000" max="999999"required>
                    </div>

                    <!--<div class="form-group col-md-4" hidden="true">--> 
                    <div class="form-group col-md-4" > 
                        <label for="OTP">Enter OTP</label>
                        <!--<input type="number" class="form-control" name="OTPhidden" id="OTPOTPhiddenid" readonly value="99">-->
                        <input type="number" class="form-control" name="OTPhidden" id="OTPOTPhiddenid" readonly >
                    </div>
                    <br>
                    <button type="submit" class="btn btn-outline-primary">Submit</button>
                </center>
            </form>
        </div>
        <%
            response.setHeader("Cache-control", "no-cache,no-store,must-revalidate");
        %>
    </body>


    <script>
//            
//            function displayError()
//            {
//                            var data = document.getElementById('errorid').innerHTML;
//                                alert("data = " + data);                 
//            if (data.length == 0)
//                {
//                        alert("data = " + data);
//                    document.getElementById('erroriddiv').style.display = "none";
//                }
//            }
        function loadpage()
        {

//       if ((e.which || e.keyCode) == 116 || (e.which || e.keyCode) == 82) e.preventDefault();
//
//$(document).ready(function(){
//     $(document).on("keydown", disableF5);
//});
//            otp sent
//            -----------------------------------------------------------------------------------------------------------------

            var data = document.getElementById('errorid').innerHTML;
//                                alert("data = " + data);                 
            if (data.length == 0)
            {
//                        alert("data = " + data);
                document.getElementById('erroriddiv').style.display = "none";
            }

            document.getElementById("OTPOTPhiddenid").value = "<%= sendOtp()%>"
        }

<!--<script type = "text/javascript" >-->
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () {
            null
        };

        document.onkeydown = function (e) {
            if (event.keyCode == 123) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)) {
                return false;
            }
        }


    </script>
</html>
