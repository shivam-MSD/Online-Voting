<%-- 
    Document   : Registration
    Created on : 10 May, 2022, 9:13:02 AM
    Author     : Admin
--%>

<%@page import="java.util.Random"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html onload="displayError()">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Registration Form</title>

        <!-- CSS only -->
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js" integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
        <link src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js">
        <link href="<c:url value="/resources/css/Form_CSS.css" />" rel="stylesheet">
        <link href="<c:url value='/resources/css/Header_CSS.css' />" rel="stylesheet">

<!--        <style>
            body
            {
                background-color: #327bb873;
            }
        </style>-->
        
    </head>

    <body onload="displayError()" id="bodyid">
        <%@include file="Header.jsp" %>
        <div class="container">
            <!--<form  class="form" action="/Home/Registration/Regsuccess.html" method="post" style="background-image: url('evote1.jpg')">-->
            <!--<form  class="form" action="Registration/Regsuccess.html" method="post" style="background-image: url('evote1.jpg')">-->
            
            <form  class="form" action="Registration.html" method="post" style="background-image: url('evote1.jpg')">
                

                <div class="regformheading">
                    <center><u><h3>${FormHeader}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="fnameid">First name</label>
                        <!--<input type="text" class="form-control" placeholder="First name" name="fname" id="fnameid" required oninput="fillName()">-->
                        <input type="text" class="form-control" placeholder="First name" name="fname" id="fnameid" required oninput="fillName()" value="${Registration.fname}">
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="lnameid">Last name</label>
                        <!--<input type="text" class="form-control" placeholder="Last name"name="lname" id="lnameid" required  oninput="fillName()">-->
                        <input type="text" class="form-control" placeholder="Last name"name="lname" id="lnameid" required  oninput="fillName()" value='${Registration.lname}'>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="aadharno">Aadhaar Number</label>
                        <!--<input type="number" class="form-control" placeholder="Aadharcard Number" name="aadharno" id="aadharno" required min="111111111111" max="999999999999">-->
                        <input type="number" class="form-control" placeholder="Aadharcard Number" name="aadharno" id="aadharno" required min="111111111111" max="999999999999" value='${Registration.aadharno}'>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="pannoid">Pan Number</label>
                        <!--<input type="text" class="form-control" placeholder="Pan Number" name="panno" id="pannoid" required>-->
                        <input type="text" class="form-control" placeholder="Pan Number" name="panno" id="pannoid" required value='${Registration.panno}'>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="vidid">Voter ID</label>
                        <!--<input type="text" class="form-control" placeholder="VoterID" name="vid" id="vidid" required>-->
                        <input type="text" class="form-control" placeholder="VoterID" name="vid" id="vidid" required value='${Registration.vid}'>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="mobnoid">Mobile No</label>
                        <!--<input type="number" class="form-control" placeholder="Mobile No registered in aadharcard" name="mobno" id="mobnoid" required>-->
                        <input type="number" class="form-control" placeholder="Mobile No registered in aadharcard" name="mobno" id="mobnoid" required value='${Registration.mobno}' min='1111111111' max="9999999999"> 
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="passwordid">Password</label>
                        <input type="password" class="form-control" placeholder="Create Password" name="password" id="passwordid" required> 
                        <!--<input type="password" class="form-control" placeholder="Create Password" name="password" id="passwordid" required value='${Registration.password}'>--> 
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="confirmpasswordid">Confirm Password</label>
                        <input type="password" class="form-control" placeholder="Confirm Password" name="confirmpassword" id="confirmpasswordid" required>
                        <!--<input type="password" class="form-control" placeholder="Confirm Password" name="confirmpassword" id="confirmpasswordid" required value='${Registration.confirmpassword}'>>-->
                    </div>
                </div>   
                    <div class="form-group col-md-6" hidden>        
                        <label for="fnameid">Name</label>
                        <input type="text" class="form-control" placeholder="Name" name="name" id="nameid" value="${Registration.name}" readonly >
                        <!--<input type="text" class="form-control" placeholder="Name" name="name" id="nameid" value="${Registration.name}" readonly >-->
                    </div>

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

                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="emailid">Email ID</label>
<!--                        <input type="email" class="form-control" placeholder="Email id" name="email" id="emailid" required data-toggle="popover" title="Email ID" data-content="You will receive Email Verification code at the time of registration and online Voting.So enter appropriate emailid">-->
                        <input type="email" class="form-control" placeholder="Email id" name="email" id="emailid" required data-toggle="popover" title="Email ID" data-content="You will receive Email Verification code at the time of registration and online Voting.So enter appropriate emailid" value='${Registration.email}'>
                        <!--<button type="button" class="btn btn-lg btn-danger" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">Click to toggle popover</button>-->
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="captcha">Captcha</label>
<!--                        <input type="text" class="form-control" name="captcha" id="captchaid" placeholder="Captcha">-->
                            <input type="text" class="form-control" name="captcha" id="captchaid" placeholder="Captcha" >
                    </div>
                </div>

                <center>
                    <b>
                        <!--<p style="font-weight: bold;">Captcha</p>-->
                            <input type="text" class="form-group col-md-2" value="<%= getCaptcha()%>" name="captchahidden" id="captchaid" readonly style="background-color: lightgrey; font-weight: bolder; margin-left: 15px;">
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
//        alert("data = " + data);
        function displayError()
        {
//            document.getElementById("bodyid").style.background-color: "#327bb873";
            var data = document.getElementById('errorid').innerHTML;
//            alert("data = " + data);
            if (data.length == 0)
            {
//                alert("data = " + data);
                document.getElementById('erroriddiv').style.display = "none";
                document.getElementById('errorid').style.display = "none";
            }
        }
//        function preventBack() { window.history.forward(); }  
//    setTimeout("preventBack()", 0);  
//    window.onunload = function () { null };  
    function fillName()
    {
        var fname = document.getElementById('fnameid').innerHTML.value;
        var lname = document.getElementById('lnameid').innerHTML.value;
//        alert(fname + " " + lname);
        fname = document.getElementById('fnameid').value;
        lname = document.getElementById('lnameid').value;
//        alert(fname + " " + lname);
        document.getElementById('nameid').value = fname  + " " + lname;
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
