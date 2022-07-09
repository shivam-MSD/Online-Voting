<%-- 
    Document   : Home
    Created on : 10 May, 2022, 9:12:27 AM
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Online Voting System</title>

        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js" integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="<c:url value="/resources/css/Home_CSS.css" />" rel="stylesheet">
    </head>
    <body onload="loadhomepage()">
        <div class="headernavbar">
            <div class="d-flex justify-content-between" id="nav1">

                <div class="p-3 bd-highlight"><img src="<c:url value='/resources/img/evoteheaderimg.jpg' />" class="rounded"></div>
                <div class="p-3 bd-highlight" ng-app="myApp" ng-controller="myCtrl"><h1 class="time" style="font-size:3vw;">{{theTime}}</h1></div>
            </div>
            <nav class="navbar navbar-expand-lg navbar-light justify-content-end" id='nav2'>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto" >
                        <li class="nav-item active">
                            <a class="nav-link" href="http://localhost:8080/OnlineVotingSession/Home/" style="font-size: 3.0vh;">Home <span class="sr-only">(current)</span></a>
                        </li>

<!--                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-expanded="false" style="font-size: 3.0vh;">
                                About Political Parties
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="font-size: 3.0vh;">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Something else here</a>
                            </div>
                        </li>-->
                        <li class="nav-item">
                            <a class="nav-link" href="https://en.wikipedia.org/wiki/List_of_political_parties_in_India" style="font-size: 3.0vh;">About Political Parties</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/Home/Registration.html" style="font-size: 3.0vh;">Register</a>
                            <!--<a class="nav-link" href="https://online-evoting.herokuapp.com/Home/Registration.html" style="font-size: 3.0vh;">Register</a>-->
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="/Home/Voting/login" style="font-size: 3.0vh;">Give Vote</a>
                            <!--<a class="nav-link" href="https://online-evoting.herokuapp.com/Home/Voting/login" style="font-size: 3.0vh;">Give Vote</a>-->
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="/Home/result" style="font-size: 3.0vh;">Past Election Result</a>
                            <!--<a class="nav-link " href="https://online-evoting.herokuapp.com/Home/result" style="font-size: 3.0vh;">Past Election Result</a>-->
                        </li>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="https://www.nvsp.in/" style="font-size: 3.0vh;">Generate New VoterID</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>

        <!--<div class="container-fluid col-md-12">-->
        <div class="container" >
            <div id="myCarousel" class="carousel slide" data-ride="carouse1">
                <!-- Wrapper for slides -->
                <div class="carousel-inner">

                    <div class="item active">
                        <img src="<c:url value='/resources/img/desc_img2.jpg'  />" style="width:100%;">
                        <div class="carousel-caption">
                            <h3>100% Secure election</h3>
                            <p>Go and Register to vote online</p>
                        </div>
                    </div>

                    <div class="item">
                        <img src="<c:url value='/resources/img/desc_img3.jpg'  />" style="width:100%;">
                        <div class="carousel-caption">
                            <h3>100% Secure election</h3>
                            <p>Go and Register to vote online</p>
                        </div>
                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Next</span>
                </a>



                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <!--<li data-target="#myCarousel" data-slide-to="2"></li>-->
                </ol>
            </div>
                       
                        <!--container ends here-->
        </div>  

        <!--<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>--> 

    <center>
        <u><div class="about-voting-heading"><h1 style="font-size: 6vh;font-weight: bold;font-family: cursive">About eVote</h1></div></u>
    </center>

    <div class="row" style="font-family: cursive">
        <div class="col-md-5">
            <img src="<c:url value='/resources/img/content_img2.jpg'  />" style="width:100%; margin: 10px;" class="rounded">
        </div>
        <div class="col-md-7" id="displayparacontent">
            <h4 style="font-size: 2.5vh;" id="displayaboveevotecontent">
                <br><br>
                <p>
                    eVote is an election system that facilitates voters to record their secure and secret ballot
                    electronically. It has a friendly user interface and enables voters to cast their votes in few
                    simple steps. We ensures the authenticity of the voters and the votes cast by them along with
                    non-traceability of the casted vote. eVote's robust architecture has persistently manifested to be
                    one of the most reliable, comprehensible and economical electronic voting solution.
                </p>
                <br>
                <p>
                    It renders Simple and Accessible voter experience that eventually increases voter engagement and
                    turnout. Auditable, Easy To Use, Secure and Reliable is what sets eVote apart from its competitors.
                </p>
                <br>
                <p>
                    eVote has facilitated several organizations, across a wide range of industries to conduct
                    hassle-free electronic voting with utmost security and integrity. Some of our fortes include
                    outstanding and prompt customer support, highly secure and trustworthy elections and last but not
                    the least; our potential to be able to tabulate expeditious and accurate results.
                </p>
                <br>
                <p>
                    We’d welcome the opportunity to work with you to provide exceptional and unparalleled service and
                    add you to our ever-growing list of satisfied clients.
                </p>
            </h4>
        </div>
    </div>
        <br><br><br>

        <center>
            <div class="about-voting-heading">
                <u><h1 style="font-size: 6vh;font-weight: bold;font-family: cursive">Evoting steps</h1></u>
                <h3 style="font-size: 3vh;font-weight: bold;">The process of voting online</h3>
            </div>
            
        </center>
        <center>
            <div class="responsive" style="font-family: cursive;">
                <div class="row" id="step1">
                    <div class="col-md-3">
                        <img class="img-circle img-responsive" src="<c:url value='/resources/img/step1.png'  />"  alt="Image not found">
                    </div>
                    <div class="col-md-9">
                        <div class="step-content">
                            <h1 class="p" style="font-size: 3vh;text-align: left;">
                                <spam>Registration</spam> Voter has to do registration for Voting Online. <br>(click on register
                                link present on Menu Bar )
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="row" id="step2">
                    <div class="col-md-3">
                        <img class="img-circle img-responsive" src="<c:url value='/resources/img/step2.png'  />"  alt="Image not found">
                    </div>
                    <div class="col-md-9">

                        <div class="step-content">
                            <h1 class="p" style="font-size: 3vh;text-align: left;">
                                <spam>Vote</spam> Voter vote online after login from voter login form. <br>(click on Give Vote
                                link present on Menu Bar to login and vote)
                            </h1>
                        </div>
                    </div>
                </div>

                <div class="row" id="step3">
                    <div class="col-md-3">
                        <img class="img-circle img-responsive" src="<c:url value='/resources/img/step3.png'  />"  alt="Image not found">
                    </div>
                    <div class="col-md-9">

                        <div class="step-content">
                            <h1 class="p" style="font-size: 3vh;text-align: left;">
                                <spam>Result</spam> Anyone can see the past election result.<br>(click
                                on Past Result which is present on Menu Bar ) <br> &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
                                &nbsp &nbsp 
                                OR <br> Search Election Result by Entering Date <br>
                                (Enter date of Election and click on Search Result button which is present on Menu Bar )
                            </h1>
                        </div>
                    </div>
                </div>
            </div>
        </center>
                    
                    
                    
                    
                    
    <!--footer-->
    <!-- Footer -->
    <footer class="page-footer font-small mdb-color lighten-3 pt-4" style="background-color: #559cd6;">

  <!-- Footer Elements -->
  <div class="container">

    <!--Grid row-->
    <div class="row">

      <!--Grid column-->
      <div class="col-lg-2 col-md-12 mb-4">

        <!--Image-->
        <div class="view overlay z-depth-1-half">
          <!--<img src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(73).webp" class="img-fluid"alt="">-->
          <img src="<c:url value='/resources/img/NPP.jpg'  />" class="img-fluid rounded-circle" alt="">
          <a href="">
            <div class="mask rgba-white-light"></div>
          </a>
        </div>

      </div>
          
      <!--Grid column-->

      
      
      
      <!--Grid column-->
      <div class="col-lg-2 col-md-6 mb-4">

        <!--Image-->
        <div class="view overlay z-depth-1-half">
          <!--<img src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(78).webp" class="img-fluid"alt="">-->
          <img src="<c:url value='/resources/img/CPIM.png'  />" class="img-fluid rounded-circle"alt="" >
          <a href="">
            <div class="mask rgba-white-light"></div>
          </a>
        </div>

      </div>
      <!--Grid column-->

      <!--Grid column-->
      <div class="col-lg-2 col-md-6 mb-4">

        <!--Image-->
        <div class="view overlay z-depth-1-half">
          <!--<img src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(79).webp" class="img-fluid"alt="">-->
          <img src="<c:url value='/resources/img/BSP.jpg'  />" class="img-fluid rounded-circle" alt="">
          <a href="">
            <div class="mask rgba-white-light"></div>
          </a>
        </div>

      </div>
      <!--Grid column-->

      <!--Grid column-->
      <div class="col-lg-2 col-md-12 mb-4">

        <!--Image-->
        <div class="view overlay z-depth-1-half">
          <!--<img src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(81).webp" class="img-fluid"alt="">-->
          <img src="<c:url value='/resources/img/AITC.jpg'  />" class="img-fluid rounded-circle" alt="">
          <a href="">
            <div class="mask rgba-white-light"></div>
          </a>
        </div>

      </div>
      <!--Grid column-->

      <!--Grid column-->
      <div class="col-lg-2 col-md-6 mb-4">

        <!--Image-->
        <div class="view overlay z-depth-1-half">
          <!--<img src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(82).webp" class="img-fluid"alt="">-->
          <img src="<c:url value='/resources/img/INC.jpg'  />" class="img-fluid rounded-circle" alt="">
          <a href="">
            <div class="mask rgba-white-light"></div>
          </a>
        </div>

      </div>
      <!--Grid column-->

      <!--Grid column-->
      <div class="col-lg-2 col-md-6 mb-4">

        <!--Image-->
        <div class="view overlay z-depth-1-half">
          <img src="<c:url value='/resources/img/BJP.png'  />" class="img-fluid rounded-circle" alt="">
          <a href="">
            <div class="mask rgba-white-light"></div>
          </a>
        </div>

      </div>
      <!--Grid column-->

    </div>
    <!--Grid row-->

  </div>
  <!-- Footer Elements -->

  <!-- Copyright -->
  <div class="footer-copyright text-center py-3">© 2022 Copyright:
    <a href="/"> OnlineVotingSystem.com</a>
  </div>
  <!-- Copyright -->

</footer>
<!-- Footer -->
    
    
</body>

<script>
    var app = angular.module('myApp', []);
    app.controller('myCtrl', function ($scope, $interval) {
        var x = new Date().toLocaleTimeString();
        $scope.theTime = x;
        $interval(function () {
            x = new Date().toLocaleTimeString();
            $scope.theTime = x;
        }, 1000);
    });

    function loadhomepage()
    {
    }


</script>
</html>