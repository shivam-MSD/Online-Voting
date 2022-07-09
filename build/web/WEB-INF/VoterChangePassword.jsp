<%-- 
    Document   : VoterChangePassword
    Created on : 28 May, 2022, 2:22:35 PM
    Author     : Admin
--%>

<%-- 
    Document   : StateAdminChangePassword
    Created on : 28 May, 2022, 10:25:04 AM
    Author     : Admin
--%>


<%@page errorPage="500_ErrorPage.jsp" %>
<%@page import="VotingSystemController.Mail"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Voter Change Password</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <link href='<c:url value="/resources/css/Form_CSS.css" />' rel="stylesheet">

    </head>
    <body onload="loadpage()">
        <%@include file="Header.jsp" %>

        <div class="container" >
            <form  class="form" action="" method="post">
                <!--                <div class="regformheading">
                                    <b><center><u><h3>Admin Login</h3></u></center></b>
                                </div>-->

                <div class="regformheading">
                    <center><u><h3>${voterloginheading}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>

                <br>

                <div class="form-row">
                    <div class="form-group col-md-6">     
                        <label for="aidid">VoterID</label>
                        <input type="text" class="form-control" placeholder="voterID" name="vid" id="vidid" required value = "${r.vid}">
                    </div>
                    <!--</div>-->

                    <%!
                        public String getCaptcha() {

                            char data[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
                                'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
                                'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
                                'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
                                'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6',
                                '7', '8', '9'};
                            char index[] = new char[7];

                            Random r = new Random();
                            int i = 0;

                            for (i = 0; i < (index.length); i++) {
                                int ran = r.nextInt(data.length);
                                index[i] = data[ran];
                            }
                            return new String(index);
                        }
                    %>

                    <!--<div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="passwordid">Old Password</label>
                        <input type="password" class="form-control" placeholder="Password" value="" name="oldpassword" id="passwordid" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="passwordid">New Password</label>
                        <input type="password" class="form-control" placeholder="New Password" value="" name="newpassword" id="passwordid" required>
                    </div>
                    <!--</div>-->

                    <!--<div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="passwordid">Confirm Password</label>
                        <input type="password" class="form-control" placeholder="Confirm Password" value="" name="confirmnewpassword" id="passwordid" required>
                    </div>
                </div>

                <center>

                    <div class="form-group col-md-3">        
                        <label for="captcha">Captcha</label>
                        <input type="text" class="form-control col-md-9" name="captcha" id="captchaid" placeholder="Captcha" required>
                    </div>
                    <!--</div>-->
                </center>
                <center>
                    <b> <input type="text" class="form-group col-md-2" value="<%= getCaptcha()%>" name="captchahidden" id="captchaid" readonly style="background-color: lightgrey; font-weight: bolder">
                        <br>
                        <button type="submit" class="btn btn-outline-primary">Change Password</button>
                </center>
            </form>
        </div>


    </body>

    <script>
        function loadpage()
        {
            var data = document.getElementById('errorid').innerHTML;
//            alert("data = " + data);
            if (data.length == 0)
            {
//                alert("data = " + data);
                document.getElementById('erroriddiv').style.display = "none";
                document.getElementById('errorid').style.display = "none";
            }

        }


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
