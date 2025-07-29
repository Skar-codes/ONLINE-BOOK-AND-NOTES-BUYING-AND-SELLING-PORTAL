package in.sp.dbcon;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/SendOTPVerifyEmail")
public class SendOTPVerifyEmail extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 
    	String toEmail = request.getParameter("email");
        String otp = request.getParameter("otp") ;
         
        final String from = "bookstore6825@gmail.com"; 
        final String password = "tevj mrxl wyzc blkx"; 
     try {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, "OnlineBookBuyingAndSellingPortal"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Your OTP Code");
            message.setText("Your OTP for verify email for register with OnlineBookBuyingAndSellingPortal is : " + otp +". Do not share with anyone");

            Transport.send(message);
            response.getWriter().print("OTP sent successfully to your email!");
            
        } catch (Exception e) {
            response.getWriter().print("Failed to send OTP. Error: "+ e.getMessage());
        }
    }
}


