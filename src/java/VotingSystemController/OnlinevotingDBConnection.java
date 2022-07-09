/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VotingSystemController;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Admin
 */
public class OnlinevotingDBConnection {
    
    static Connection con;
    public static Connection createConnection()
    {
             String url = "jdbc:mysql://localhost:3308/onlinevotingsystemdb";
             String driver = "com.mysql.jdbc.Driver";
             String userName = "root";
             String password = "";
        try
        {
            // load the driver class
            System.out.println("before connection 1");
            Class.forName(driver);     
             System.out.println("before connection 2");
            con = DriverManager.getConnection(url, userName,password);
//            con = DriverManager.getConnection(url, url, password)
                 System.out.println("after connection");           
        }
        catch(Exception e)
        {
            System.out.println("Exception in connection");
            e.printStackTrace();
        }
        return con;
    }
}
