<%-- 
    Document   : index
    Created on : 10 Dec, 2020, 7:39:32 PM
    Author     : shika
--%>

<%@ page import="java.sql.*" %>  
<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/TonkaBI","root",""); //create connection
	
	if(request.getParameter("btn_link")!=null) //check link button click event not null
	{
		String dbname;
		String EmpName;
                EmpName = request.getParameter("txt_name");
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("select * from empsalary where EmpName=?"); //sql select query 
		pstmt.setString(1,EmpName);
		
		
		ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
		
		if(rs.next())
		{
			dbname=rs.getString("EmpName");
			if(EmpName.equals(dbname))
			{%>
                        
<style>
       
            #myButton {
                        background: none!important;
                        border: none;
                        padding: 0!important;
                        text-decoration: underline; 
                      }
            #div1 {
                        position: absolute;
                        top: 50%;
                        width: 100%;
                        text-align: center;
                        font-size: 18px;
                  }
</style>

<div id="div1">                   
<center> 
    <br><br><br>
        <input type = "button" style ="background-color:transparent" id= "myButton" value= "Click here for Salary Details" onclick="window.location.href='salary.jsp?ename=<%=rs.getString(2)%>'" />
        <br><br><p style="color:red" id="statusMsg" >  </p>
        <!--a href="salary.jsp?ename=<%=rs.getString(2)%>" id="myButton">Click here for details</a></center>   --> 
</center>
</div>
                       
<%}
		}
		else
		{
			request.setAttribute("errorMsg","Name not present"); //invalid error message for email or password wrong
		}
		
		con.close(); //close connection	
	}
	
}
catch(Exception e)
{
	out.println(e);
}
%>

<!DOCTYPE html>
<html>

<head>
    <script   src="https://code.jquery.com/jquery-2.2.3.js"   
    integrity="sha256-laXWtGydpwqJ8JA+X9x2miwmaiKhn8tVmOVEigRNtP4="   
    crossorigin="anonymous"></script>
    
    <script>
$(document).ready(function(){
   var limit = 5000*1; // the time limit (in milliseconds) for the disable function
   var timer = setTimeout(disableMyButton, limit);

   function disableMyButton(){
      $('#myButton').prop('disabled', true);
      $("#statusMsg").text("Link Expired!");
      $.cookie.setItem("isMyButtonDisabled", "true");
   }

   if($.cookie.getItem("isMyButtonDisabled") == "true"){
     $('#myButton').prop('disabled', true);
     window.clearTimeout(timer);
   }
});
</script>
    

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Employee Salary</title>

	<link rel="stylesheet" href="CSS/main.css">
	<link rel="stylesheet" href="CSS/login-register.css">
	
	<script>
		
		function validate()
		{
			var name = document.myform.txt_name;	
			if (name.value == null || name.value == "") //check name textbox not blank
			{
				window.alert("please enter name ?"); //alert message
				email.style.background = '#f08080';
				email.focus();
				return false;
			}
		}
            function disableElement(){
                $('#elementId').prop('disabled', true);
                        

                setTimeout(disableElement, 5000*1);
            }       
              
			
	</script>
	
</head>

<body>

    <div class="main-content">

        <form class="form-register" method="post" name="myform" onsubmit="return validate();">

            <div class="form-register-with-email">

                <div class="form-white-background">

                    <div class="form-title-row">
                        <h1>Your Details</h1>
                    </div>
					
					<p style="color:red">				   		
					<%
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for name 
					}
					%>
					</p>
				   
				   </br>

                        <div class="form-row">
                        <label>
                            <span>Your name</span>
                            <input type="text" name="txt_name" id="EmpName" autocomplete="off">
                        </label>
                        </div>
                        <input style="background-color: royalblue; color: white" type="submit" name="btn_link" value="Get Details" >
                        </div>
            </div>
        </form>
    </div>
</body>
</html>


