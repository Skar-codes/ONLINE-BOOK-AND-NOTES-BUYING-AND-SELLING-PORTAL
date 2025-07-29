/**
 * 
 */

function sendOTPResetPassword() {
	
    const email = document.getElementById("email").value;
    const otpverify = document.getElementsByClassName('otpverify')[0];
    const otp = Math.floor(100000 + Math.random() * 900000);
	const resend =document.getElementById("resend");
	const send =document.getElementById("send");
	if (email === "") {
		        alert("Please enter your email address.");
		        return; // Stop further execution
		    }
	fetch("SendOTPResetPassword", {
	               method: "POST",
	               headers: {
	                   "Content-Type": "application/x-www-form-urlencoded",
	               },
	               body: `email=${encodeURIComponent(email)}&otp=${encodeURIComponent(otp)}`
	           })
    .then(response => response.text())
    .then(data => {
        alert(data);
        if (data.trim() === "OTP sent successfully to your email!") {
            otpverify.style.display = "flex";
			send.style.display ="none";
			resend.style.display ="flex";

            const otp_inp = document.getElementById("otp_inp");
            const otp_btn = document.getElementById("otp-btn");

            otp_btn.addEventListener('click', () => {
                if (parseInt(otp_inp.value) == otp) {
                    //alert("Email address verified.");
					window.location.href = `resetPassword.jsp?userid=${encodeURIComponent(email)}`;
                } else {
                    alert("Invalid OTP");
                }
            });
        }
		
    })
    .catch(error => {
        alert("Failed to send OTP. Error: " + error);
    });
}
function sendOTPEmailVerify() {
	
    const email = document.getElementById("Remail").value;
    const otpverify = document.getElementsByClassName('otpverify')[0];
	const verifyEmail = document.getElementById("verifyEmail");
	const detailInputs = document.querySelectorAll(".input-box-detail");
    const otp = Math.floor(100000 + Math.random() * 900000);
	if (email === "") {
	        alert("Please enter your email address.");
	        return; // Stop further execution
	    }
	
	fetch("SendOTPVerifyEmail", {
	               method: "POST",
	               headers: {
	                   "Content-Type": "application/x-www-form-urlencoded",
	               },
	               body: `email=${encodeURIComponent(email)}&otp=${encodeURIComponent(otp)}`
	           })
    .then(response => response.text())
    .then(data => {
        alert(data);
        if (data.trim() === "OTP sent successfully to your email!") {
            otpverify.style.display = "block";
			verifyEmail.style.display = "none";
			
            const otp_inp = document.getElementById("otp_inp");
            const otp_btn = document.getElementById("otp-btn");

            otp_btn.addEventListener('click', () => {
                if (parseInt(otp_inp.value) == otp) {
                    alert("Email verified successfully!");
					//window.location.href = `resetPassword.jsp?userid=${encodeURIComponent(email)}`;
					detailInputs.forEach(input => {
					                       input.style.display = "block";
					                   });

					                   // Show final register button
					document.getElementById("submitRegisterBtn").style.display = "block";
					
					
					otpverify.style.display = "none";
					
                } else {
                    alert("Invalid OTP. Try again.");
                }
            });
        }
		else{
			 
				 	
				}
    })
    .catch(error => {
        alert("Failed to send OTP. Error occured: ");
    });
}

function validatePassword(){
	const pass = document.getElementById("password").value;
	const Confirmpass = document.getElementById("confirmPassword").value;
	
	const testPass = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/;
	
	
	if(!testPass.test(pass))
	{
				 alert("❌ Password must contain:\n- Min 8 characters\n- At least 1 uppercase letter\n- At least 1 lowercase letter\n- At least 1 digit\n- At least 1 special character");
		         return false;
				 
	 }
    if(pass !== Confirmpass)
	{
		        alert("❌ Password and Confirm Password do not match");
				return false;
	 }
	 return true;
}
