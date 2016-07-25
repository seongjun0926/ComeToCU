<%@ page import="java.io.*,com.oreilly.servlet.*,com.oreilly.servlet.multipart.*"%>

<% request.setCharacterEncoding("euc-kr"); %> 

<html>
<head><title>upload test</title></head>
<body>
<h3>파일 upload</h3>


<%  
        String dir=application.getRealPath("/Upload/img");
        int max= 5*1024*1024;

        //최대크기 max바이트, dir 디렉토리에 파일을 업로드하는 MultipartRequest
        //객체를 생성한다.
        MultipartRequest m = new MultipartRequest(request,dir,max,"UTF-8",

                                               new  DefaultFileRenamePolicy());
%>

<c:set var="file1" value='<%= m.getFilesystemName("file1")%>' />   // 파일이름을 file1 이라는 파라메터로 넘겨받음
<c:set var="ofile1" value='<%= m.getOriginalFileName("file1") %>' />


<p>

<li>제목: ${subject}<br>
<li>업로드파일1: <a href=/Upload/img/${file1}>${ofile1}</a><br>

</body>
</html>