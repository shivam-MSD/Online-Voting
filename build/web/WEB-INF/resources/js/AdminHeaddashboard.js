/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function addNewAdmin()
{
    alert("Add Admin");
    window.open("http://localhost:8080/OnlineVoting/Admin/login/adminheaddashboard/addadmin");
}

$(document).ready(function () {
    alert("hiii");
  $('#dtHorizontalVerticalExample').DataTable({
    "scrollX": true,
    "scrollY": 200,
  });
  $('.dataTables_length').addClass('bs-select');
});