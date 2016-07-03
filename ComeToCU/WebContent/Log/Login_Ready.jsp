<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>로그인</title>
<script type="text/javascript" src="/Log/httpRequest.js"></script>
<script type="text/javascript">

function digit_check(evt){
   var code = evt.which?evt.which:event.keyCode;
   if(code < 48 || code > 57){
   return false;
   }
}
</script>



</head>
<body>
   <br>
   <div class="col-xs-12">
      <form action="/Log/LoginProcess.jsp" method="POST">   
         <table class="table table-bordered" valign="middle">

            <tr>
               <th colspan="4">
                  <div class="input-group">

                     <span class="input-group-addon" id="S_Num">학번</span> <input
                        name="S_Num" type="text" class="form-control"
                        placeholder="학번을 입력해주세요." aria-describedby="basic-addon1"
                        required autofocus onkeypress="return digit_check(event)">
                  </div>
               </th>
               <td rowspan="2">

                  <button class="btn btn-default btn-lg btn-block" type="submit">입장</button>

               </td>

            </tr>

            <tr>
               <th colspan="4">
                  <div class="input-group">

                     <span class="input-group-addon" id="S_PW">암호</span> <input
                        name="S_PW" type="password" class="form-control"
                        placeholder="암호를 입력해주세요." aria-describedby="basic-addon1"
                        required>
                  </div>
               </th>

            </tr>

            <tr>
               <td colspan="4">
                  <div class="text-center">
                     <a href="/Log/Register.jsp"><u>암호를 잊었습니다</u></a>
                  </div>
               </td>

               <td colspan="4">
                  <div class="text-center">
                     <a href="/Log/Register.jsp"><u>회원가입</u></a>
                  </div>
               </td>
            </tr>





         </table>
      </form>
   </div>
</body>
</html>