<%-- 
    Document   : EditCandidatebyadminsuccess
    Created on : 19 May, 2022, 12:33:51 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="loadpage()">
        <!--<h1>Hello World!</h1>-->
    </body>
    <script>
        function loadpage()
        {
            window.open("/Admin/login/admindashboard","_self");
//            window.open("https://online-evoting.herokuapp.com/Admin/login/admindashboard","_self");
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