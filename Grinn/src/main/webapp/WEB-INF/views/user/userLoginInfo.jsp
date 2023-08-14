<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
  $(".email-button").click(function() { // Use 'email-button' class to target email button
    var $emailContainer = $(this).closest(".email-section");
    var $emailText = $emailContainer.find(".email-text");
    var $emailInput = $emailContainer.find(".email-input");
    var $button = $(this);
    
    if ($emailText.is(":visible")) {
      $emailText.hide();
      $emailInput.show();
      $emailInput.val($emailText.text());
      $button.text("저장 ");
      $emailContainer.find("h5").css("font-weight", "bold").css("opacity", 1);
    } else {
      var newEmail = $emailInput.val();
      $.post("/user/updateEmail", { newEmail: newEmail }, function(response) {
        if (response === "success") {
          $emailText.text(newEmail);
          $emailInput.hide();
          $emailText.show();
          $button.text("변경");
          $emailContainer.find("h5").css("font-weight", "normal").css("opacity", 0.3);
        } else {
          alert("이메일 주소 변경에 실패했습니다.");
        }
      });
    }
  });
	
  $(".password-button").click(function() {
	  var $passwordContainer = $(this).closest(".password-section");
	  var $passwordText = $passwordContainer.find(".password-text"); // Modify class to match the actual class of the password element
	  var $passwordInput = $passwordContainer.find(".password-input");
	  var $button = $(this);
	  
	  if ($passwordText.is(":visible")) {
	    $passwordText.hide();
	    $passwordInput.show();
	    $passwordInput.val(""); // Clear the input field
	    $button.text("저장 ");
	    $passwordContainer.find("h5").css("font-weight", "bold").css("opacity", 1);
	  } else {
	    var newPassword = $passwordInput.val();
	    $.post("/user/updatePassword", { newPassword: newPassword }, function(response) {
	      if (response === "success") {
	        // Update password display (if needed) and reset the input field
	        $passwordText.text(newPassword); // Update the class accordingly
	        $passwordInput.hide();
	        $passwordText.show();
	        $button.text("변경");
	        $passwordContainer.find("h5").css("font-weight", "normal").css("opacity", 0.3);
	      } else {
	        alert("비밀번호 변경에 실패했습니다.");
	      }
	    });
	  }
	});
  
  $(".phone-button").click(function() { // Use 'phone-button' class to target phone button
    var $sectionContainer = $(this).closest(".section-border");
    var $phoneText = $sectionContainer.find(".phone-text");
    var $phoneInput = $sectionContainer.find(".phone-input");
    var $button = $(this);
    
    if ($phoneText.is(":visible")) {
      $phoneText.hide();
      $phoneInput.show();
      $phoneInput.val($phoneText.text());
      $button.text("저장 ");
      $sectionContainer.find("h5").css("font-weight", "bold").css("opacity", 1);
    } else {
      var newPhone = $phoneInput.val();
      $.post("/user/updatePhoneNumber", { newPhone: newPhone }, function(response) {
        if (response === "success") {
          $phoneText.text(newPhone);
          $phoneInput.hide();
          $phoneText.show();
          $button.text("변경");
          $sectionContainer.find("h5").css("font-weight", "normal").css("opacity", 0.3);
        } else {
          alert("전화번호 변경에 실패했습니다.");
        }
      });
    }
  });
});
</script>

<style>
.bordered-heading {
  border-bottom: 2px solid #000;
  padding-bottom: 20px;
}

.section-border {
  border-bottom: 0.5px solid rgba(0, 0, 0, 0.3);
  width: 50%; 
}

h5 {
  margin-bottom: -15px;
  opacity: 0.3; /* 투명도 조정 */
  font-weight: normal;
}

.button {
  background-color: white; /* 배경색 */
  color: black; /* 글자색 */
  border: 1px solid rgba(0, 0, 0, 0.3); /* 테두리 스타일 */
  border-radius: 10px; /* 모서리 둥글게 */
  padding: 5px 10px;
  cursor: pointer;
}
.email-input-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.email-input {
  border: none;
  border-bottom: 1px solid rgba(0, 0, 0, 0.3);
  border-radius: 0;
  padding: 5px 0;
  margin-top: 25px;
}

/* Adjust button style to maintain its position */
.button-container {
  display: flex;
  align-items: center;
  justify-content: space-between;"
}

.phone-input-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.phone-input {
  border: none;
  border-bottom: 1px solid rgba(0, 0, 0, 0.3);
  border-radius: 0;
  padding: 5px 0;
  margin-top: 25px;
}

.password-input-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.password-input {
  border: none;
  border-bottom: 1px solid rgba(0, 0, 0, 0.3);
  border-radius: 0;
  padding: 5px 0;
  margin-top: 25px;
}
</style>
<!-- 회원정보 시작 -->
<div class="page-main">
  <h2 class="bordered-heading" style="font-size: 24px;">로그인 정보</h2>
  <br>

<div class="email-section section-border">
  <h2 style="font-size: 18px;">내 계정</h2>
  <h5 style="font-size: 13px; margin-bottom: 1px;">이메일 주소</h5>
  <div class="button-container"> <!-- Use the button-container for button positioning -->
    <p style="font-size: 16px; margin-right: 10px;" class="email-text">${member.mem_email}</p>
    <div class="email-input-container"> <!-- Wrap input in a container -->
      <input type="text" class="email-input" style="display: none;">
    </div>
    <button class="button email-button">변경</button> <!-- Button is outside the email-input-container -->
  </div>
</div>

<div class="password-section section-border">
  <h5 style="font-size: 13px; margin-bottom: 1px;">비밀번호</h5>
  <div class="button-container">
    <p style="font-size: 16px; margin-right: 10px;" class="password-text">${member.mem_passwd}</p> <!-- Display password dots or placeholder -->
    <div class="password-input-container">
      <input type="password" class="password-input" style="display: none;">
    </div>
    <button class="button password-button">변경</button>
  </div>
</div>

  <br><br>		
<div class="phone-section section-border">
  <h2>개인 정보</h2>
  <h5 style="font-size: 13px; margin-bottom: 1px;">휴대폰 번호</h5>
  <div class="button-container">
    <p style="font-size: 16px; margin-right: 10px;" class="phone-text">${member.mem_phone}</p>
    <div class="phone-input-container">
      <input type="text" class="phone-input" style="display: none;">
    </div>
    <button class="button phone-button">변경</button>
  </div>
</div>
</div>
<!-- 회원정보 끝 -->
