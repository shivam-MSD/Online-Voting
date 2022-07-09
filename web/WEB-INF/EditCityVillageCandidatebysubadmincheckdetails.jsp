<%-- 
    Document   : EditCityVillageCandidatebysubadmincheckdetails
    Created on : 20 May, 2022, 8:20:46 PM
    Author     : Admin
--%>

<%-- 
    Document   : Addcitycandidatebysubadmincheckdetails
    Created on : 19 May, 2022, 11:25:39 PM
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


        <style>
            form
            {
                margin-bottom: 30px;
            }
        </style>
        
    </head>

    <body onload="displayError()" id="bodyid" ng-app="myApp" ng-controller="myCtrl">
        <%@include file="AdminHeader.jsp" %>
        
        <%! String cityadminid; %>
        
        <div class="container">

            <form  class="form" action="editcitycandidatesuccess" method="post" style="background-image: url('evote1.jpg')" >

                <div class="regformheading">
                    <center><u><h3>${formheader}</h3></u></center>
                </div>
                <br>
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="positionid">Position of candidate in election</label>
                        <input type="text" class="form-control" placeholder="position of candidate" name="position" id="positionid" required value='${candidate.position}' readonly>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="municorpoid">Municipal Corporation of </label>
                        <input type="text" class="form-control" placeholder="Enter Village name in village field" name="municorpo" id="municorpo" required value='{{municorponame}}' readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">        
                        <label for="vidid">Voter ID</label>
                        <input type="text" class="form-control" placeholder="VoterID" name="vid" id="vidid" required value='${candidate.vid}' readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="nameid">Candidate Name</label>
                        <input type="text" class="form-control" placeholder="Name" name="cname" id="cnameid" value="${candidate.cname}" readonly >
                    </div>
                </div>
                    <div class="form-row" hidden>
                    <div class="form-group col-md-6">        
                        <label for="aadharno">Aadhaar Number</label>
                        <input type="number" class="form-control" placeholder="Aadharcard Number" name="aadharno" id="aadharno" required min="111111111111" max="999999999999" value='${candidate.aadharno}' readonly>
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="pannoid">Pan Number</label>
                        <input type="text" class="form-control" placeholder="Pan Number" name="panno" id="pannoid" required value='${candidate.panno}' readonly>
                    </div>
                </div>
                <div class="form-row">

                    <div class="form-group col-md-6">
                        <label for="partynameid">Party Name</label>
                        <input type="text" class="form-control" placeholder="Partyname of candidate" name="partyname" id="partyname" required value='${candidate.partyname}' readonly>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="pannoid">Select Party Logo</label>
                        <input type="file" id="imgid" name="partylogo" class="form-control" >
                    </div>
                </div>

                <div class="form-row">

                    <div class="form-group col-md-6">        
                        <label for="stateid">Candidate of which state? Select State</label><br>
                        <select name="state" class="form-control"          
                                ng-model="selectstate" 
                                ng-options="x for x in names"
                                required id="stateid" name="state"
                                onchange="makeSubmenu(this.value)" id="countrySelect"> 
                            <option value="${candidate.state}" disabled selected>Select State</option> 
                        </select>  
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="mobnoid">Candidate of which city? Select City</label><br>
                        <select id="citySelect" size="1" class="form-control"  required name="city" >
                            <option value="" disabled selected>Choose City</option>
                            <!--<option></option>-->
                        </select>
                    </div>
                </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">        
                        <label for="villageid">Candidate of which village? Enter village name</label><br>
                        <input type="text" class="form-control" placeholder="Enter Village Name" name="village" id="villageid" required value='${candidate.village}' ng-model="municorponame">
                    </div>
                        <div class="form-group col-md-6">        
                            <label for="wardnoid">Ward Number</label>
                            <input type="number" class="form-control" placeholder="Aadharcard Number" name="wardno" id="wardnoid" required min="1" max="99999999" value='${candidate.wardno}' >
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
            
            <%
                                                session = (HttpSession) request.getSession(false);
                                                cityadminid = (String) session.getAttribute("cityadminid");
                                                if (cityadminid == null) {
//                                                    RequestDispatcher rd = request.getRequestDispatcher("AllAdminlogin.jsp");
//                                                    rd.forward(request, response); 
                                                      %>
                                                         window.open("/Subadmin/login","_self");
//                                                         window.open("https://online-evoting.herokuapp.com/Subadmin/login","_self");
                                                      <%
                                                }
                                                

                                                     %>
        }
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () {
            null
        };



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
                "Punjab",
                "Rajasthan",
                "Sikkim",
                "Tamil Nadu",
                "Tripura",
                "Uttarakhand",
                "Uttar Pradesh",
                "West Bengal",
                "Chandigarh",
                "Dadra and Nagar Haveli",
                "Daman and Diu",
                "Delhi",
                "PondPonicherry"];

            $scope.save = function (myForm) {
                console.log('Selected Value: ' + myForm.state.$modelValue);
                alert('Data Saved! without validate');
            };
        });


        // *************************************************************************************************************************   








        var citiesByState = {
            "Andhra Pradesh": [
                'Adilabad',
                'Anantapur',
                'Chittoor',
                'Kakinada',
                'Guntur',
                'Hyderabad',
                'Karimnagar',
                'Khammam',
                'Krishna',
                'Kurnool',
                'Mahbubnagar',
                'Medak',
                'Nalgonda',
                'Nizamabad',
                'Ongole',
                'Hyderabad',
                'Srikakulam',
                'Nellore',
                'Visakhapatnam',
                'Vizianagaram',
                'Warangal',
                'Eluru',
                'Kadapa',
            ],
            "Arunachal Pradesh": [
                'Anjaw',
                'Changlang',
                'East Siang',
                'Kurung Kumey',
                'Lohit',
                'Lower Dibang Valley',
                'Lower Subansiri',
                'Papum Pare',
                'Tawang',
                'Tirap',
                'Dibang Valley',
                'Upper Siang',
                'Upper Subansiri',
                'West Kameng',
                'West Siang',
            ],
            Assam: [
                'Baksa',
                'Barpeta',
                'Bongaigaon',
                'Cachar',
                'Chirang',
                'Darrang',
                'Dhemaji',
                'Dima Hasao',
                'Dhubri',
                'Dibrugarh',
                'Goalpara',
                'Golaghat',
                'Hailakandi',
                'Jorhat',
                'Kamrup',
                'Kamrup Metropolitan',
                'Karbi Anglong',
                'Karimganj',
                'Kokrajhar',
                'Lakhimpur',
                'Marigaon',
                'Nagaon',
                'Nalbari',
                'Sibsagar',
                'Sonitpur',
                'Tinsukia',
                'Udalguri',
            ],
            Bihar: [
                'Araria',
                'Arwal',
                'Aurangabad',
                'Banka',
                'Begusarai',
                'Bhagalpur',
                'Bhojpur',
                'Buxar',
                'Darbhanga',
                'East Champaran',
                'Gaya',
                'Gopalganj',
                'Jamui',
                'Jehanabad',
                'Kaimur',
                'Katihar',
                'Khagaria',
                'Kishanganj',
                'Lakhisarai',
                'Madhepura',
                'Madhubani',
                'Munger',
                'Muzaffarpur',
                'Nalanda',
                'Nawada',
                'Patna',
                'Purnia',
                'Rohtas',
                'Saharsa',
                'Samastipur',
                'Saran',
                'Sheikhpura',
                'Sheohar',
                'Sitamarhi',
                'Siwan',
                'Supaul',
                'Vaishali',
                'West Champaran',
                'Chandigarh',
            ],
            Chhattisgarh: [
                'Bastar',
                'Bijapur',
                'Bilaspur',
                'Dantewada',
                'Dhamtari',
                'Durg',
                'Jashpur',
                'Janjgir-Champa',
                'Korba',
                'Koriya',
                'Kanker',
                'Kabirdham (Kawardha)',
                'Mahasamund',
                'Narayanpur',
                'Raigarh',
                'Rajnandgaon',
                'Raipur',
                'Surguja',
            ],
            "Dadra and Nagar Haveli": [
                'Dadra and Nagar Haveli'
            ],
            "Daman and Diu": [
                'Daman',
                'Diu',
            ],
            Delhi: [
                'Central Delhi',
                'East Delhi',
                'New Delhi',
                'North Delhi',
                'North East Delhi',
                'North West Delhi',
                'South Delhi',
                'South West Delhi',
                'West Delhi',
            ],
            Goa: [
                'North Goa',
                'South Goa'
            ],
            Gujarat: [
                'Ahmedabad',
                'Amreli district',
                'Anand',
                'Banaskantha',
                'Bharuch',
                'Bhavnagar',
                'Dahod',
                'The Dangs',
                'Gandhinagar',
                'Jamnagar',
                'Junagadh',
                'Kutch',
                'Kheda',
                'Mehsana',
                'Narmada',
                'Navsari',
                'Patan',
                'Panchmahal',
                'Porbandar',
                'Rajkot',
                'Sabarkantha',
                'Surendranagar',
                'Surat',
                'Vyara',
                'Vadodara',
                'Valsad',
            ],
            Haryana: [
                'Ambala',
                'Bhiwani',
                'Faridabad',
                'Fatehabad',
                'Gurgaon',
                'Hissar',
                'Jhajjar',
                'Jind',
                'Karnal',
                'Kaithal',
                'Kurukshetra',
                'Mahendragarh',
                'Mewat',
                'Palwal',
                'Panchkula',
                'Panipat',
                'Rewari',
                'Rohtak',
                'Sirsa',
                'Sonipat',
                'Yamuna Nagar',
            ],
            "Himachal Pradesh": [
                'Bilaspur',
                'Chamba',
                'Hamirpur',
                'Kangra',
                'Kinnaur',
                'Kullu',
                'Lahaul and Spiti',
                'Mandi',
                'Shimla',
                'Sirmaur',
                'Solan',
                'Una',
            ],
            "Jammu and Kashmir": [
                'Anantnag',
                'Badgam',
                'Bandipora',
                'Baramulla',
                'Doda',
                'Ganderbal',
                'Jammu',
                'Kargil',
                'Kathua',
                'Kishtwar',
                'Kupwara',
                'Kulgam',
                'Leh',
                'Poonch',
                'Pulwama',
                'Rajauri',
                'Ramban',
                'Reasi',
                'Samba',
                'Shopian',
                'Srinagar',
                'Udhampur',
            ],
            Jharkhand: [
                'Bokaro',
                'Chatra',
                'Deoghar',
                'Dhanbad',
                'Dumka',
                'East Singhbhum',
                'Garhwa',
                'Giridih',
                'Godda',
                'Gumla',
                'Hazaribag',
                'Jamtara',
                'Khunti',
                'Koderma',
                'Latehar',
                'Lohardaga',
                'Pakur',
                'Palamu',
                'Ramgarh',
                'Ranchi',
                'Sahibganj',
                'Seraikela Kharsawan',
                'Simdega',
                'West Singhbhum',
            ],
            Karnataka: [
                'Bagalkot',
                'Bangalore Rural',
                'Bangalore Urban',
                'Belgaum',
                'Bellary',
                'Bidar',
                'Bijapur',
                'Chamarajnagar',
                'Chikkamagaluru',
                'Chikkaballapur',
                'Chitradurga',
                'Davanagere',
                'Dharwad',
                'Dakshina Kannada',
                'Gadag',
                'Gulbarga',
                'Hassan',
                'Haveri district',
                'Kodagu',
                'Kolar',
                'Koppal',
                'Mandya',
                'Mysore',
                'Raichur',
                'Shimoga',
                'Tumkur',
                'Udupi',
                'Uttara Kannada',
                'Ramanagara',
                'Yadgir',
            ],
            Kerala: [
                'Alappuzha',
                'Ernakulam',
                'Idukki',
                'Kannur',
                'Kasaragod',
                'Kollam',
                'Kottayam',
                'Kozhikode',
                'Malappuram',
                'Palakkad',
                'Pathanamthitta',
                'Thrissur',
                'Thiruvananthapuram',
                'Wayanad',
            ],
            "Madhya Pradesh": [
                'Alirajpur',
                'Anuppur',
                'Ashok Nagar',
                'Balaghat',
                'Barwani',
                'Betul',
                'Bhind',
                'Bhopal',
                'Burhanpur',
                'Chhatarpur',
                'Chhindwara',
                'Damoh',
                'Datia',
                'Dewas',
                'Dhar',
                'Dindori',
                'Guna',
                'Gwalior',
                'Harda',
                'Hoshangabad',
                'Indore',
                'Jabalpur',
                'Jhabua',
                'Katni',
                'Khandwa (East Nimar)',
                'Khargone (West Nimar)',
                'Mandla',
                'Mandsaur',
                'Morena',
                'Narsinghpur',
                'Neemuch',
                'Panna',
                'Rewa',
                'Rajgarh',
                'Ratlam',
                'Raisen',
                'Sagar',
                'Satna',
                'Sehore',
                'Seoni',
                'Shahdol',
                'Shajapur',
                'Sheopur',
                'Shivpuri',
                'Sidhi',
                'Singrauli',
                'Tikamgarh',
                'Ujjain',
                'Umaria',
                'Vidisha',
            ],
            Maharashtra: [
                'Ahmednagar',
                'Akola',
                'Amravati',
                'Aurangabad',
                'Bhandara',
                'Beed',
                'Buldhana',
                'Chandrapur',
                'Dhule',
                'Gadchiroli',
                'Gondia',
                'Hingoli',
                'Jalgaon',
                'Jalna',
                'Kolhapur',
                'Latur',
                'Mumbai City',
                'Mumbai suburban',
                'Nandurbar',
                'Nanded',
                'Nagpur',
                'Nashik',
                'Osmanabad',
                'Parbhani',
                'Pune',
                'Raigad',
                'Ratnagiri',
                'Sindhudurg',
                'Sangli',
                'Solapur',
                'Satara',
                'Thane',
                'Wardha',
                'Washim',
                'Yavatmal',
            ],
            Manipur: [
                'Bishnupur',
                'Churachandpur',
                'Chandel',
                'Imphal East',
                'Senapati',
                'Tamenglong',
                'Thoubal',
                'Ukhrul',
                'Imphal West',
            ],
            Meghalaya: [
                'East Garo Hills',
                'East Khasi Hills',
                'Jaintia Hills',
                'Ri Bhoi',
                'South Garo Hills',
                'West Garo Hills',
                'West Khasi Hills',
            ],
            Mizoram: [
                'Aizawl',
                'Champhai',
                'Kolasib',
                'Lawngtlai',
                'Lunglei',
                'Mamit',
                'Saiha',
                'Serchhip',
            ],
            Nagaland: [
                'Dimapur',
                'Kohima',
                'Mokokchung',
                'Mon',
                'Phek',
                'Tuensang',
                'Wokha',
                'Zunheboto',
            ],
            Orissa: [
                'Angul',
                'Boudh (Bauda)',
                'Bhadrak',
                'Balangir',
                'Bargarh (Baragarh)',
                'Balasore',
                'Cuttack',
                'Debagarh (Deogarh)',
                'Dhenkanal',
                'Ganjam',
                'Gajapati',
                'Jharsuguda',
                'Jajpur',
                'Jagatsinghpur',
                'Khordha',
                'Kendujhar (Keonjhar)',
                'Kalahandi',
                'Kandhamal',
                'Koraput',
                'Kendrapara',
                'Malkangiri',
                'Mayurbhanj',
                'Nabarangpur',
                'Nuapada',
                'Nayagarh',
                'Puri',
                'Rayagada',
                'Sambalpur',
                'Subarnapur (Sonepur)',
                'Sundergarh',
            ],
            PondPonicherry: [
                'Karaikal',
                'Mahe',
                'Pondicherry',
                'Yanam',
            ],
            Punjab: [
                'Amritsar',
                'Barnala',
                'Bathinda',
                'Firozpur',
                'Faridkot',
                'Fatehgarh Sahib',
                'Fazilka',
                'Gurdaspur',
                'Hoshiarpur',
                'Jalandhar',
                'Kapurthala',
                'Ludhiana',
                'Mansa',
                'Moga',
                'Sri Muktsar Sahib',
                'Pathankot',
                'Patiala',
                'Rupnagar',
                'Ajitgarh (Mohali)',
                'Sangrur',
                'Nawanshahr',
                'Tarn Taran',
            ],
            Rajasthan: [
                'Ajmer',
                'Alwar',
                'Bikaner',
                'Barmer',
                'Banswara',
                'Bharatpur',
                'Baran',
                'Bundi',
                'Bhilwara',
                'Churu',
                'Chittorgarh',
                'Dausa',
                'Dholpur',
                'Dungapur',
                'Ganganagar',
                'Hanumangarh',
                'Jhunjhunu',
                'Jalore',
                'Jodhpur',
                'Jaipur',
                'Jaisalmer',
                'Jhalawar',
                'Karauli',
                'Kota',
                'Nagaur',
                'Pali',
                'Pratapgarh',
                'Rajsamand',
                'Sikar',
                'Sawai Madhopur',
                'Sirohi',
                'Tonk',
                'Udaipur',
            ],
            Sikkim: [
                'East Sikkim',
                'North Sikkim',
                'South Sikkim',
                'West Sikkim',
            ],
            "Tamil Nadu": [
                'Ariyalur',
                'Chennai',
                'Coimbatore',
                'Cuddalore',
                'Dharmapuri',
                'Dindigul',
                'Erode',
                'Kanchipuram',
                'Kanyakumari',
                'Karur',
                'Madurai',
                'Nagapattinam',
                'Nilgiris',
                'Namakkal',
                'Perambalur',
                'Pudukkottai',
                'Ramanathapuram',
                'Salem',
                'Sivaganga',
                'Tirupur',
                'Tiruchirappalli',
                'Theni',
                'Tirunelveli',
                'Thanjavur',
                'Thoothukudi',
                'Tiruvallur',
                'Tiruvarur',
                'Tiruvannamalai',
                'Vellore',
                'Viluppuram',
                'Virudhunagar',
            ],
            Tripura: [
                'Dhalai',
                'North Tripura',
                'South Tripura',
                'Khowai',
                'West Tripura',
            ],
            "Uttar Pradesh": [
                'Agra',
                'Allahabad',
                'Aligarh',
                'Ambedkar Nagar',
                'Auraiya',
                'Azamgarh',
                'Barabanki',
                'Budaun',
                'Bagpat',
                'Bahraich',
                'Bijnor',
                'Ballia',
                'Banda',
                'Balrampur',
                'Bareilly',
                'Basti',
                'Bulandshahr',
                'Chandauli',
                'Chhatrapati Shahuji Maharaj Nagar',
                'Chitrakoot',
                'Deoria',
                'Etah',
                'Kanshi Ram Nagar',
                'Etawah',
                'Firozabad',
                'Farrukhabad',
                'Fatehpur',
                'Faizabad',
                'Gautam Buddh Nagar',
                'Gonda',
                'Ghazipur',
                'Gorakhpur',
                'Ghaziabad',
                'Hamirpur',
                'Hardoi',
                'Mahamaya Nagar',
                'Jhansi',
                'Jalaun',
                'Jyotiba Phule Nagar',
                'Jaunpur district',
                'Ramabai Nagar (Kanpur Dehat)',
                'Kannauj',
                'Kanpur',
                'Kaushambi',
                'Kushinagar',
                'Lalitpur',
                'Lakhimpur Kheri',
                'Lucknow',
                'Mau',
                'Meerut',
                'Maharajganj',
                'Mahoba',
                'Mirzapur',
                'Moradabad',
                'Mainpuri',
                'Mathura',
                'Muzaffarnagar',
                'Panchsheel Nagar district (Hapur)',
                'Pilibhit',
                'Shamli',
                'Pratapgarh',
                'Rampur',
                'Raebareli',
                'Saharanpur',
                'Sitapur',
                'Shahjahanpur',
                'Sant Kabir Nagar',
                'Siddharthnagar',
                'Sonbhadra',
                'Sant Ravidas Nagar',
                'Sultanpur',
                'Shravasti',
                'Unnao',
                'Varanasi',
            ],
            Uttarakhand: [
                'Almora',
                'Bageshwar',
                'Chamoli',
                'Champawat',
                'Dehradun',
                'Haridwar',
                'Nainital',
                'Pauri Garhwal',
                'Pithoragarh',
                'Rudraprayag',
                'Tehri Garhwal',
                'Udham Singh Nagar',
                'Uttarkashi',
            ],
            "West Bengal": [
                'Birbhum',
                'Bankura',
                'Bardhaman',
                'Darjeeling',
                'Dakshin Dinajpur',
                'Hooghly',
                'Howrah',
                'Jalpaiguri',
                'Cooch Behar',
                'Kolkata',
                'Maldah',
                'Paschim Medinipur',
                'Purba Medinipur',
                'Murshidabad',
                'Nadia',
                'North 24 Parganas',
                'South 24 Parganas',
                'Purulia',
                'Uttar Dinajpur',
            ]
        }
        function makeSubmenu(value) {
            //            alert("state = " + value);
            let value1 = value.split(":");
            if (value1[1].length == 0)
                document.getElementById("citySelect").innerHTML = "<option></option>";
            else {
                var citiesOptions = "";
                for (cityId in citiesByState[value1[1]]) {
                    citiesOptions += "<option>" + citiesByState[value1[1]][cityId] + "</option>";
                }
                document.getElementById("citySelect").innerHTML = citiesOptions;
            }
        }
        function displaySelected() {
            var country = document.getElementById("countrySelect").value;
            var city = document.getElementById("citySelect").value;
            alert(country + "\n" + city);
        }
        function resetSelection() {
            document.getElementById("countrySelect").selectedIndex = 0;
            document.getElementById("citySelect").selectedIndex = 0;
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
