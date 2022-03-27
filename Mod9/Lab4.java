import java.sql.*;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class Lab4 {

  //Method that has the example program code in it. Given to me from Russ Wakefield. Credit to Russ Wakefield
  public static void example(){
    Connection con = null;
    try {
      Statement stmt;
      ResultSet rs;
      Class.forName("com.mysql.jdbc.Driver");
      String url = "jdbc:mysql://faure/jtyndale?serverTimezone=UTC";
      con = DriverManager.getConnection(url,"jtyndale", "831786992");
      stmt = con.createStatement();
	try{
        rs = stmt.executeQuery("SELECT * FROM Author");
        while (rs.next()) {
          System.out.println (rs.getString("author_ID"));
      }
      }catch(Exception e){
        System.out.print(e);
        System.out.println(
                  "No Author table to query");
      }//end catch
      con.close();
    }catch( Exception e ) {
      e.printStackTrace();
    }//end catch
  }//end example

	//Method to read in and parse xml data, given to me from Russ Wakefield. Credit to Russ Wakefield
  public void readXML(String xml_data){
		try {
			File file = new File(xml_data);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(file);
			doc.getDocumentElement().normalize();
			NodeList nodeLst = doc.getElementsByTagName("Borrowed_by");

			for (int s = 0; s < nodeLst.getLength(); s++) {
				Node fstNode = nodeLst.item(s);
				if (fstNode.getNodeType() == Node.ELEMENT_NODE) {
					Element sectionNode = (Element) fstNode;
					
					NodeList memberIdElementList = sectionNode.getElementsByTagName("MemberID");
					Element memberIdElmnt = (Element) memberIdElementList.item(0);
					NodeList memberIdNodeList = memberIdElmnt.getChildNodes();
					String member_ID = ((Node) memberIdNodeList.item(0)).getNodeValue().trim();

					NodeList secnoElementList = sectionNode.getElementsByTagName("ISBN");
					Element secnoElmnt = (Element) secnoElementList.item(0);
					NodeList secno = secnoElmnt.getChildNodes();
					String isbn = ((Node) secno.item(0)).getNodeValue().trim();

					NodeList codateElementList = sectionNode.getElementsByTagName("Checkout_date");
					Element codElmnt = (Element) codateElementList.item(0);
					NodeList cod = codElmnt.getChildNodes();
					String check_out = ((Node) cod.item(0)).getNodeValue().trim();

					NodeList cidateElementList = sectionNode.getElementsByTagName("Checkin_date");
					Element cidElmnt = (Element) cidateElementList.item(0);
					NodeList cid = cidElmnt.getChildNodes();
					String check_in = ((Node) cid.item(0)).getNodeValue().trim();

					// Update database
					if (check_out.equals("N/A"))
						checkIn(member_ID, isbn, check_out, check_in);
					else if (check_in.equals("N/A"))
						checkOut(member_ID, isbn, check_out, check_in);
					System.out.println();
				}//end if
			}//end for
		}//end try 
		catch (Exception e) {
			e.printStackTrace();
		}//end catch
	}//end ReadXML method

	public void checkIn(String member_ID, String isbn, String check_out, String check_in) {
		System.out.println("Check In: ");
		String update = "UPDATE Borrowed_By SET checkin_date = \'" + check_in + "\' WHERE member_ID = " + member_ID + " AND ISBN = \'" + isbn + "\'";
		System.out.println(update);
		if(!checkData(member_ID, isbn, check_out, check_in, "checkin")) {
			System.out.println("\tERROR: Book does not have a checkout date. Checkin not possible");
			return;
		}
		else{
			System.out.println("\tBook has a checkout date. Checkin succesful");
		}
		Connection con = null;
		try {
			Statement stmnt;
			//ResultSet rs;
			Class.forName("com.mysql.jdbc.Driver");// Register the JDBC driver for MySQL
			String url =  "jdbc:mysql://faure/jtyndale?serverTimezone=UTC";// Define URL of database server
			con = DriverManager.getConnection(url,"jtyndale", "831786992");// Get a connection to the database
			stmnt = con.createStatement();// Get Statement object
			stmnt.executeUpdate(update);// Update record
			con.close();
		} 
		catch (Exception e) {
			System.out.println("ERROR Updating Borrowed_By (" + member_ID + ", \'" + isbn + "\', \'" + check_out + "\', \'" + check_in + "\')");
		}
	}

	public void checkOut(String member_ID, String isbn, String check_out, String check_in) {
		System.out.println("Check Out: ");
		String insert = "INSERT INTO Borrowed_By VALUES (" + member_ID + ", \'" + isbn + "\', \'" + check_out + "\', \'\')";
		System.out.println(insert);
		if(!(checkData(member_ID, isbn, check_out, check_in, "checkout"))) {
			System.out.println("\tERROR: Book isn't available/doesn't exist. Checkout not possible");
			return;
		}
		else{
			System.out.println("\tBook exists. Checkout sucessful");
		}
		Connection con = null;
		try {
			Statement stmnt;
			Class.forName("com.mysql.jdbc.Driver");// Register the JDBC driver for MySQL
			String url =  "jdbc:mysql://faure/jtyndale?serverTimezone=UTC";// Define URL of database server
			con = DriverManager.getConnection(url,"jtyndale", "831786992");// Get a connection to the database
			stmnt = con.createStatement();// Get Statement object
			stmnt.executeUpdate(insert);// Create new record
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}



	public boolean checkData(String member_ID, String isbn, String check_out, String check_in, String action) {

		Connection con = null;
		try {
			Statement stmnt;
			ResultSet rs;
			Class.forName("com.mysql.jdbc.Driver");	// Register the JDBC driver for MySQL
			String url =  "jdbc:mysql://faure/jtyndale?serverTimezone=UTC";// Define URL of database server
			con = DriverManager.getConnection(url,"jtyndale", "831786992");// Get a connection to the database
			stmnt = con.createStatement();// Get Statement obj
			if (action.equals("checkin")) {// checkin
				try{
					rs = stmnt.executeQuery("SELECT * FROM Borrowed_By");
					while (rs.next()) {
						if(rs.getString("checkout_date").equals("N/A") || rs.getString("checkout_date").length() == 0) {
							System.out.println("Invalid checkout date " + rs.getString("checkout_date"));
							return false;
						}
					}
					return true;
				}catch(Exception e){
					System.out.print(e);
				}
			}
			else {// checkouts
				try{
					rs = stmnt.executeQuery("SELECT * FROM Located_at");
					while (rs.next()) {
						if(rs.getString("ISBN").equals(isbn) && Integer.parseInt(rs.getString("Total_copies")) > 0)
							return true;
					}
					return false;
				}catch(Exception e){
					System.out.print(e);
				}
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}





  public static void main(String args[]){
	try {
		Lab4 showXML = new Lab4();
		showXML.readXML ("/s/bach/a/class/cs430dl/Current/more_assignments/LabData/Libdata.xml");
	}catch( Exception e ) {
		e.printStackTrace();
	}//end try-catch
  }//end main

}//end class

