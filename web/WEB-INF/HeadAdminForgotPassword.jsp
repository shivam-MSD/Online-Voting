<%-- 
    Document   : HeadAdminForgotPassword
    Created on : 5 Jun, 2022, 4:11:13 PM
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
        <title>Admin Head Change Password</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js" integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
        <link src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js">
        <link href="<c:url value="/resources/css/Form_CSS.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/AddNewAdmin_CSS.css" />" rel="stylesheet">
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">

    </head>
    <body onload="loadpage()">
        <%@include file="Header.jsp" %>

        <div class="container" >
            <form  class="form" action="forgotpassword" method="post">
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
                        <label for="aidid">AdminId</label>
                        <input type="text" class="form-control" placeholder="voterID" name="aid" id="aidid" required value = "${addadminmsg.aid}">
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
                    <div class="form-group col-md-6" >        
                        <label for="emailid">Email ID</label>
                        <input type="email" class="form-control" placeholder="Email id" name="email"value="${addadminmsg.email}" id="emailid">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="passwordid">New Password</label>
                        <input type="password" class="form-control" placeholder="New Password"  name="newpassword" id="passwordid" required>
                    </div>
                    <!--</div>-->

                    <!--<div class="form-row">-->
                    <div class="form-group col-md-6">        
                        <label for="passwordid">Confirm Password</label>
                        <input type="password" class="form-control" placeholder="Confirm Password"  name="confirmnewpassword" id="passwordid" required>
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
