/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VotingSystemController;

import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

    public class Mail {
//    String sendEmailTo; 
//    String vid;
//    String mailbody;
//        sendEmailTo = request.getParameter("email");
//        vid = request.getParameter("vid");

    Session newSession = null;
    MimeMessage mimeMessage;

    public Mail() {
    }
    
        public static void main(String[] args) {
            Mail m = new Mail();
        }
    
//        int otp = sendOtp();
//
//        public int sendOtp() {
//            setupServerProperties();
//            draftEmail();
//            sendMail();
//            return otp;
//        }
//
//        public String sendOtp(String sendEmailTo) {
//            setupServerProperties();
//            draftEmail();
//            sendMail();
//
//            return password;
//        }

    private void setupServerProperties() {
        Properties p = System.getProperties();
        p.put("mail.smtp.port", "587");
        p.put("mail.smtp.auth", "true");
        p.setProperty("mail.smtp.starttls.enable", "true");
        p.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        newSession = Session.getDefaultInstance(p, null);

    }

    public MimeMessage draftEmail(String sendEmailTo,String subject) {
        String from = "shivapatel1102001@gmail.com";
        String mailsubject = subject;
        String body = "Evoting Registration OTP";
        mimeMessage = new MimeMessage(newSession);

        try {
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(sendEmailTo));
            mimeMessage.setSubject(subject);
            MimeMultipart multipart = new MimeMultipart();
            MimeBodyPart bodyPart = new MimeBodyPart();
//                bodyPart.setContent(body, "text/plain");
            bodyPart.setContent(body, "text/html");
            MimeMultipart multiPart = new MimeMultipart();
            multiPart.addBodyPart(bodyPart);
            mimeMessage.setContent(multiPart);
            return mimeMessage;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void sendMail(String mailbody) {
        String fromUser = "shivapatel1102001@gmail.com";

        String userPassword = "mdgbfgicunisbbcg";

        String emailHost = "smtp.gmail.com";

        try {
            mailbody = mailbody + "\n\nRegards,\nEvoting Team";
            mimeMessage.setText(mailbody);

            Transport tp = newSession.getTransport("smtp");
            System.out.println("Establising connection... 1");
            tp.connect(emailHost, fromUser, userPassword);
            System.out.println("Establising connection...2");
            tp.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
            System.out.println("Establising connection...");
            tp.close();
            System.out.println("Email successfully Send");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendMailNow(String sendEmailTo,String subject,String mailbody)
    {
        setupServerProperties();
        draftEmail(sendEmailTo,subject);
        sendMail(mailbody);
    }
    public int generateOTP(String sendEmailTo, String vid, String purpose) {

        Random r = new Random();
        int low = 100000;
        int high = 999999;
        int x = r.nextInt(high - low) + low;
        String.format("%06d", x);
        String subject;
        String mailbody;
        if (purpose.equals("registration")) {
            subject = "EVoting Registration OTP";
            mailbody = "Dear voter,\n\t VoterId :- " + vid + "\n\t Email verification code for Evoting Registration is " + Integer.parseInt(String.format("%06d", x));
        } else if (purpose.equals("voting")) {
            subject = "Voting OTP";
            mailbody = "Dear voter,\n\t VoterId :- " + vid + "\n\t Email verification code for Voting is " + Integer.parseInt(String.format("%06d", x));
        } 
        else if (purpose.equals("forgotpassword")) {
            subject = "Forgot Password Evoting OTP";
            mailbody = "Dear voter,\n\t VoterId :- " + vid + "\n\t Email verification code for forgot password is " + Integer.parseInt(String.format("%06d", x));
        }
        else {
            subject = "Error.....";
            mailbody = "something wend wrong....";
        }
        setupServerProperties();
        draftEmail(sendEmailTo,subject);
        sendMail(mailbody);
        return Integer.parseInt(String.format("%06d", x));
    }

    public String generateAdminPassword(String vid, String aid, String state, String city, String village, String sendEmailTo, String name) {
        String password = getCaptcha();
        String mailbody;
        String subject = "Evoting Admin Selection";
        if (city.length() == 0) {
            mailbody = "Hello " + name + ",\n\t\tYou are selected as EVoting Admin of State.Your details are display below : \nAdminID :-" + aid + "\nPassword for Admin Login :- " + password + "\nYour VoterID :- " + vid + "\nEvoting Admin of State :- " + state + "\n\nIf you want to update your password, click on the link below.";
            
        } //            else if(village==null)
        else if(village.length()==0){
            mailbody = "Hello " + name + ",\n\t\tYou are selected as EVoting Admin of city.Your details are display below : \nAdminID :-" + aid + "\nPassword for Admin Login :- " + password + "\nYour VoterID :- " + vid + "\nEvoting Admin of :- State : " + state + " and City : " + city + "\n\nTo update the admin login password to your convinient password, click on link below to update the password.";
        }
        else
        {
            mailbody = "Hello " + name + ",\n\t\tYou are selected as EVoting Admin of village.Your details are display below : \nAdminID :-" + aid + "\nPassword for Admin Login :- " + password + "\nYour VoterID :- " + vid + "\nEvoting Admin of :- State : " + state + ", City : " + city + " and village : " + village + "\n\nTo update the admin login password to your convinient password, click on link below to update the password";
        }

        sendMailNow(sendEmailTo,subject,mailbody);
//        setupServerProperties();
//        draftEmail(sendEmailTo,subject);
//        sendMail(mailbody);
        System.out.println("********** +++++ Password = " + password + " ++++++++++++****************");
        return password;
    }

    public String getCaptcha() {

        char data[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
            'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
            'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
            'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
            'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6',
            '7', '8', '9'};
        char index[] = new char[7];

        Random r = new Random();
        int i = 0;

        for (i = 0; i < (index.length); i++) {
            int ran = r.nextInt(data.length);
            index[i] = data[ran];
        }
        return new String(index);
    }
    // send mail logic

//        public String sendMail()
//        {
//            
//        }
/*
    Session newSession = null;
    MimeMessage mimeMessage;

    public static void main(String[] args) {

        //SETUP 3 DIFFERENT METHODS
        Mail mail = new Mail();
        mail.setupServerProperties();
        mail.draftEmail();
        mail.sendMail();

    }

    private void setupServerProperties() {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        Properties p = System.getProperties();
        p.put("mail.smtp.port", "587");
        p.put("mail.smtp.auth", "true");
        p.setProperty("mail.smtp.starttls.enable", "true");
        p.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        newSession = Session.getDefaultInstance(p, null);

    }

    private MimeMessage draftEmail() {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        String sendTo = "shivapatel1102001@gmail.com";
        String from = "shivapatel1102001@gmail.com";
        String subject = "Test Mail";
        String body = "Test body of email";
        mimeMessage = new MimeMessage(newSession);

        try {
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
            mimeMessage.setSubject(subject);
            MimeMultipart multipart = new MimeMultipart();
            MimeBodyPart bodyPart = new MimeBodyPart();
            bodyPart.setContent(body, "text/plain");
//            bodyPart.setContent(body, "html/text");
            MimeMultipart multiPart = new MimeMultipart();
            multiPart.addBodyPart(bodyPart);
            mimeMessage.setContent(multiPart);
            return mimeMessage;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void sendMail() {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        String fromUser = "shivapatel1102001@gmail.com";

        String userPassword = "mdgbfgicunisbbcg";

        String emailHost = "smtp.gmail.com";

        try {
            
            Random r = new Random();
            int x = r.nextInt(9999);
            mimeMessage.setText("Welcome to JavaMail\n OTP = " + x);
            
            Transport tp = newSession.getTransport("smtp");
            System.out.println("Establising connection... 1");
            tp.connect(emailHost, fromUser, userPassword);
            System.out.println("Establising connection...2");
            tp.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
            System.out.println("Establising connection...");
            tp.close();
            System.out.println("Email successfully Send");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    
     */
}
