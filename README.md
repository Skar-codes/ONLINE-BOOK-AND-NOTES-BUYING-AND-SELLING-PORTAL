# ONLINE-BOOK-AND-NOTES-BUYING-AND-SELLING-PORTAL
An end-to-end database-focused portal for students to buy and sell books online with integrated payments. Built using Java (backend), MySQL (database), JavaScript, HTML, and CSS (frontend), with Razorpay for secure and seamless payment processing.

🔧 Features
👤 User Authentication: Register and log in to access personalized features.
📖 Sell Books: List used books with pricing, description, and contact details.
🛒 Browse & Buy: Search and view available listings posted by other users.
💳 Integrated Payment Gateway: Secure checkout using Razorpay.
🗃️ Database-Driven: MySQL powers the backend with complete CRUD operations.

🛠 Tech Stack
Layer            	  Technology
Frontend	      HTML, CSS, JavaScript
Backend	        Java (Servlets/JSP)
Database	          MySQL
Payment	        Razorpay Integration
Web Server      Apache Tomcat (if used)


🚀 Getting Started
1. Setup Database
Import the SQL schema from /database/schema.sql into your MySQL server.
Configure DB connection details in your Java backend (usually in DBConnection.java).

2. Run the Application
Open the project in Eclipse / IntelliJ / NetBeans / Android Studio (for Java Web).
Deploy on Apache Tomcat or your preferred Java server.

💳 Razorpay Integration
Set up a Razorpay account.
Generate test/live API keys.
Insert them in your payment handler script (usually payment.jsp or a Java servlet).
