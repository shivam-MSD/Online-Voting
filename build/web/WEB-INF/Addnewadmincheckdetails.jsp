<%-- 
    Document   : Addnewadmincheckdetails
    Created on : 14 May, 2022, 1:08:58 PM
    Author     : Admin
--%>

<%-- 
    Document   : Registration
    Created on : 10 May, 2022, 9:13:02 AM
    Author     : Admin
--%>
<%@page errorPage="ErrorPage.jsp" %>
<%@page import="java.util.Random"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html onload="displayError()">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Add New Admin Details</title>

        <!-- CSS only -->
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
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
        <!--<link href="<c:url value='/resources/css/AdminHeaddashboard_CSS.css' />" rel="stylesheet">-->
        <!--<link href="<c:url value='/resources/js/AdminHeaddashboard.js' />" rel="stylesheet">-->


    </head>

    <body onload="displayError()" id="bodyid" ng-app="myApp" ng-controller="myCtrl">
        <%@include file="AdminHeader.jsp" %>
        <div class="container">

            <form  class="form" action="addadminsuccess" method="post" style="background-image: url('evote1.jpg')" ng-submit="save(myForm)">

                <div class="regformheading">
                    <center><u><h3>${formheader}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="aidid">Admin Id</label>
                        <input type="text" class="form-control" placeholder="AdminID" name="aid" id="aidid" required value='${addadminmsg.aid}' readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="vidid">Voter ID</label>
                        <input type="text" class="form-control" placeholder="VoterID" name="vid" id="vidid" required value='${addadminmsg.vid}' readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="aadharno">Aadhaar Number</label>
                        <input type="number" class="form-control" placeholder="Aadharcard Number" name="aadharno" id="aadharno" required min="111111111111" max="999999999999" value='${addadminmsg.aadharno}' readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="pannoid">Pan Number</label>
                        <!--<input type="text" class="form-control" placeholder="Pan Number" name="panno" id="pannoid" required>-->
                        <input type="text" class="form-control" placeholder="Pan Number" name="panno" id="pannoid" required value='${addadminmsg.panno}' readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="nameid">Name</label>
                        <input type="text" class="form-control" placeholder="Name" name="name" id="nameid" value="${addadminmsg.name}" readonly >
                        <!--<input type="text" class="form-control" placeholder="Name" name="name" id="nameid" value="${Registration.name}" readonly >-->
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="mobnoid">Mobile No</label>
                        <!--<input type="number" class="form-control" placeholder="Mobile No registered in aadharcard" name="mobno" id="mobnoid" required>-->
                        <input type="number" class="form-control" placeholder="Mobile No registered in aadharcard" name="mobno" id="mobnoid" required value='${addadminmsg.mobno}' min='1111111111' max="9999999999" > 
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="emailid">Email ID</label>
                        <!--                        <input type="email" class="form-control" placeholder="Email id" name="email" id="emailid" required data-toggle="popover" title="Email ID" data-content="You will receive Email Verification code at the time of registration and online Voting.So enter appropriate emailid">-->
                        <input type="email" class="form-control" placeholder="Email id" name="email" id="emailid" required data-toggle="popover" title="Email ID" data-content="You will receive Email Verification code at the time of registration and online Voting.So enter appropriate emailid" value='${addadminmsg.email}'>
                        <!--<button type="button" class="btn btn-lg btn-danger" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">Click to toggle popover</button>-->
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="mobnoid">Admin of which state? Select State</label><br>
                        <select name="state" class="form-control"          
                                ng-model="selectstate" 
                                ng-options="x for x in names"
                                required id="stateid" name="state"
                                onchange="makeSubmenu(this.value)" id="countrySelect"> 
                            <option value="${candidate.state}" disabled selected>Select State</option> 
                        </select>
                    </div>
                </div>

                <center>
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

        var data = document.getElementById('errorid').innerHTML;
//            alert("data = " + data);
        if (data.length == 0)
        {
//                alert("data = " + data);
            document.getElementById('erroriddiv').style.display = "none";
            document.getElementById('errorid').style.display = "none";
        }
    }
        function preventBack() { window.history.forward(); }  
    setTimeout("preventBack()", 0);  
    window.onunload = function () { null };  



    var app = angular.module('myApp', []);
    app.controller('myCtrl', function ($scope) {
        $scope.names = ["Andhra Pradesh",
            "Arunachal Pradesh",
            "Assam",
            "Bihar",
            "Chhattisgarh",
            "Goa",
            "Gujarat",
            "Haryana",
            "Himachal Pradesh",
            "Jammu and Kashmir",
            "Jharkhand",
            "Karnataka",
            "Kerala",
            "Madhya Pradesh",
            "Maharashtra",
            "Manipur",
            "Meghalaya",
            "Mizoram",
            "Nagaland",
            "Odisha",
            "Punjab",
            "Rajasthan",
            "Sikkim",
            "Tamil Nadu",
            "Telangana",
            "Tripura",
            "Uttarakhand",
            "Uttar Pradesh",
            "West Bengal",
            "Andaman and Nicobar Islands",
            "Chandigarh",
            "Dadra and Nagar Haveli",
            "Daman and Diu",
            "Delhi",
            "Lakshadweep",
            "Puducherry"];

        $scope.save = function (myForm) {
            console.log('Selected Value: ' + myForm.state.$modelValue);
            alert('Data Saved! without validate');
        };
    });
    
    
    
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
