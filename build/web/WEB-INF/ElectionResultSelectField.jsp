<%-- 
    Document   : ElectionResultSelectField
    Created on : 29 May, 2022, 8:44:44 AM
    Author     : Admin
--%>

<%-- 
    Document   : Login
    Created on : 10 May, 2022, 9:13:16 AM
    Author     : Admin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%--<%@page errorPage="ErrorPage.jsp" %>--%>
<%@page import="VotingSystemController.Mail"%>
<%@page import="java.util.Random"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Search Election Result</title>

        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js" ></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <link href='<c:url value="/resources/css/Form_CSS.css" />' rel="stylesheet">
        <link href="<c:url value='/resources/css/AdminHeader_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/css/Subadmindashboard_CSS.css' />" rel="stylesheet">
        <link href="<c:url value='/resources/js/AdminHeaddashboard.js' />" rel="stylesheet">
        <!--<link href="<c:url value='/resources/css/ElectionResult_CSS.css' />" rel="stylesheet">-->

    </head>
    <body onload="loadpage()" ng-app="myApp" ng-controller="myCtrl">
        <%@include file="Header.jsp" %>

        <div class="container" >
            <form  class="form" action="" method="post">
                <!--<form  class="form" action="Votingdashboard" method="post">-->

                <div class="regformheading">
                    <center><u><h3>${electionresultheading}</h3></u></center>
                </div>
                <br>

                <!--<div class="form-row">-->
                <!--<center>-->
                <div class="alert alert-danger"  id="erroriddiv">
                    <h5  id="errorid">${error}</h5>
                </div>
                <div class="form-row">
                    <!--<center>-->
                    <div class="form-group col-md-6">     
                        <label for="vidid">Search election result</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="resulttype" id="wholeresultid" checked value="Whole result" onclick="selectResultType()">
                            <label class="form-check-label" for="flexRadioDefault1">
                                Whole result
                            </label>
                        </div>
                        <!--</div>-->
                        <!--<div class="form-group col-md-6">-->
                        <!--<label for="vidid"></label>-->
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="resulttype" id="byyearid" value="by Year" onclick="selectResultType()">
                            <label class="form-check-label" for="flexRadioDefault2">
                                by Year
                            </label>
                        </div>
                    </div>
                    <!--</center>-->
                    <div class="form-group col-md-6">     
                        <label for="vidid">Entry Year</label>
                        <input type="number" class="form-control" placeholder="" name="year" id="yearid" value='${candidate.year}' required disabled>
                    </div>
                </div>
                <div class="form-row">

                    <div class="form-group col-md-6">
                        <label for="positionid">Election of </label>
                        <select name="position" class="form-control" required value="${candidate.position}" id="positionid" onclick="selectPosition()"> 
                            <option value="" disabled selected>Choose Position</option>
                            <option>MLA</option>
                            <option>MP</option>
                            <option>Mayor</option>
                            <option>Sarpanch</option>
                        </select> 
                    </div>
                    <div class="form-group col-md-6">        
                        <label for="state">State</label>
                        <select name="state" class="form-control"          
                                ng-model="selectstate" 
                                ng-options="x for x in names"
                                required id="stateid" name="state"
                                onclick="makeSubmenu(this.value)" id="countrySelect"> 
                            <option value="${candidate.state}" disabled selected>Select State</option> 
                        </select>
                    </div>
                </div>


                <div class="form-row">     

                    <div class="form-group col-md-6">        
                        <label for="mobnoid">City</label><br>
                        <select id="citySelect" size="1" class="form-control"  required name="city">
                            <option value="" disabled selected>Choose City</option>
                            <option></option>
                        </select>
                    </div>

                    <div class="form-group col-md-6">        
                        <label for="mobnoid">Enter Village Name</label><br>
                        <input type="text" class="form-control" id="villageid" name="village" id="villageid" disabled>
                    </div>
                </div>
                <center>
                    <br>
                    <button type="submit" class="btn btn-outline-primary">Show Result</button>
                    <br>
                </center>
            </form>

        </div>
    </body>

    <script>
        function loadpage()
        {

            var data = document.getElementById('errorid').innerHTML;
            document.getElementById("villageid").value = "";
            document.getElementById("yearid").value = "";

//            alert("data = " + data);
            if (data.length == 0)
            {
//                alert("data = " + data);
                document.getElementById('erroriddiv').style.display = "none";
                document.getElementById('errorid').style.display = "none";
            }
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
        
        function selectResultType()
        {
            var radios = document.getElementsByName('resulttype');
            for (var radio of radios)
            {
                if (radio.checked) {
//                alert(radio.value);

                    if (radio.value === "Whole result")
                    {
                        document.getElementById("yearid").disabled = true;
                        document.getElementById("yearid").value = "";
                    } else if (radio.value === "by Year")
                    {
                        document.getElementById("yearid").disabled = false;
                    }
                }
            }
        }

        function selectPosition()
        {
//            document.getElementById("positionid").value
            
            var select = document.getElementById('positionid');
            var option = select.options[select.selectedIndex];

		if(option.value === "Sarpanch")
                {
                    document.getElementById("villageid").disabled = false;
                    
                }
                else
                {
                    document.getElementById("villageid").disabled = true;
                    document.getElementById("villageid").value = "";
                }
        }

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
            "Andhra Pradesh": ['Choose city',
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
            "Arunachal Pradesh": ['Choose city',
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
            Assam: ['Choose city',
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
            Bihar: ['Choose city',
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
            Chhattisgarh: ['Choose city',
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
            "Dadra and Nagar Haveli": ['Choose city',
                'Dadra and Nagar Haveli'
            ],
            "Daman and Diu": ['Choose city',
                'Daman',
                'Diu',
            ],
            Delhi: ['Choose city',
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
            Goa: ['Choose city',
                'North Goa',
                'South Goa'
            ],
            Gujarat: ['Choose city',
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
            Haryana: ['Choose city',
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
            "Himachal Pradesh": ['Choose city',
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
            "Jammu and Kashmir": ['Choose city',
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
            Jharkhand: ['Choose city',
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
            Karnataka: ['Choose city',
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
            Kerala: ['Choose city',
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
            "Madhya Pradesh": ['Choose city',
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
            Maharashtra: ['Choose city',
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
            Manipur: ['Choose city',
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
            Meghalaya: ['Choose city',
                'East Garo Hills',
                'East Khasi Hills',
                'Jaintia Hills',
                'Ri Bhoi',
                'South Garo Hills',
                'West Garo Hills',
                'West Khasi Hills',
            ],
            Mizoram: ['Choose city',
                'Aizawl',
                'Champhai',
                'Kolasib',
                'Lawngtlai',
                'Lunglei',
                'Mamit',
                'Saiha',
                'Serchhip',
            ],
            Nagaland: ['Choose city',
                'Dimapur',
                'Kohima',
                'Mokokchung',
                'Mon',
                'Phek',
                'Tuensang',
                'Wokha',
                'Zunheboto',
            ],
            Orissa: ['Choose city',
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
            PondPonicherry: ['Choose city',
                'Karaikal',
                'Mahe',
                'Pondicherry',
                'Yanam',
            ],
            Punjab: ['Choose city',
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
            Rajasthan: ['Choose city',
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
            Sikkim: ['Choose city',
                'East Sikkim',
                'North Sikkim',
                'South Sikkim',
                'West Sikkim',
            ],
            "Tamil Nadu": ['Choose city',
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
            Tripura: ['Choose city',
                'Dhalai',
                'North Tripura',
                'South Tripura',
                'Khowai',
                'West Tripura',
            ],
            "Uttar Pradesh": ['Choose city',
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
            Uttarakhand: ['Choose city',
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
            "West Bengal": ['Choose city',
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
