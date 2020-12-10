<%-- 
    Document   : salary
    Created on : 10 Dec, 2020, 7:39:32 PM
    Author     : shika
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); 
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/TonkaBI","root",""); 
        String name=request.getParameter("ename");
	
		String dbname;
		
		//String EmpName;
		
		//EmpName=request.getParameter("txt_name");
		
		
		PreparedStatement pstmt=null;
		
		pstmt=con.prepareStatement("select * from empsalary where Empname=?"); 
		pstmt.setString(1,name);
		
		ResultSet rs=pstmt.executeQuery(); 
		
	if(rs.next())
	{
		dbname=rs.getString("EmpName");
			
			
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Employee Salary</title>

	<link rel="stylesheet" href="CSS/main.css">
	<link rel="stylesheet" href="CSS/login-register.css">
</head>
<body>
    

    <div class="main-content">

        
<form class="form-register" name="myform">

            <div class="form-register-with-email">

                <div class="form-white-background">

                    <div class="form-title-row">
                        <h1>Your Salary</h1>
                    </div>
				   <br>
                                     <div class="form-row" >
                        <label>
                            <span>Name</span>
                            <input type="text" name="txt_name" id="EmpName" value = "<%= rs.getString(2) %>" disabled="true">
                        </label>
                        </div>
                        <div class="form-row" >
                        <label>
                            <span>Salary</span>
                            <input type="text" name="txt_name" id="EmpSalary" value="<%= rs.getString(3) %>" disabled="true">
                        </label>
                        </div>
                        
                    
                </div>
            </div>
</form>

</body>

<%
		}
		
		con.close(); 	
	}
	

catch(Exception e)
{
	out.println(e);
}
%>

</html>
