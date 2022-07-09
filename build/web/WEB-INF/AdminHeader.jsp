<%-- 
    Document   : AdminHeader
    Created on : 12 May, 2022, 11:51:34 PM
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="extensions/sticky-header/bootstrap-table-sticky-header.css">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">
    </head>
    <body>
        <header>
            <div class="d-flex justify-content-between" id="nav1">

                <div class="p-2 bd-highlight"><img src="<c:url value='/resources/img/evoteheaderimg.jpg' />" class="rounded"></div>
                <center>
                    <!--<div class="p-2 bd-highlight"><h1 id="adminheaderid"><c:out value="${aid}"></c:out></h1></div>-->
                    <div class="p-2 bd-highlight"><h1 id="adminheaderid"><i class="fa fa-user" aria-hidden="true"></i> ${adminheader}</h1></div>
                     <!--<div class="p-2 bd-highlight"><h1 id="adminheaderiddisplay">${aid}</h1></div>-->
<!--                    <div class="p-2 bd-highlight"><h1 id="adminheaderid"><c:out value="${aid}"></c:out></h1></div>-->
                </center>
                <div class="p-2 bd-highlight" ng-app="myApp" ng-controller="myCtrl"><h1 class="time" style="font-size:3vw;">{{theTime}}</h1></div>
            </div>
        </header>
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
