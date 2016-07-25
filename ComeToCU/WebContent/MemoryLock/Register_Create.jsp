<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"
	import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"
	import="java.util.*" import="java.io.*"%>

<%	
response.setCharacterEncoding("utf-8");	
request.setCharacterEncoding("UTF-8");

	String M_C_Contents="";
	String realFolder = ""; //파일경로를 알아보기위한 임시변수를 하나 만들고,
	String saveFolder = "MemoryLock/Upload/img"; //파일저장 폴더명을 설정한 뒤에...
	String encType = "utf-8"; //인코딩방식도 함께 설정한 뒤,
	int maxSize = 100 * 1024 * 1024; //파일 최대용량까지 지정해주자.(현재 100메가)
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	System.out.println("the realpath is : " + realFolder); // file path

	File dir = new File(realFolder); // 디렉토리 위치 지정
	if (!dir.exists()) { // 디렉토리가 존재하지 않으면
		dir.mkdirs(); // 디렉토리 생성.!
	}
	try {
		//멀티파트생성과 동시에 파일은 저장이 되고...
		MultipartRequest multi = null;
		multi = new MultipartRequest(request, realFolder, maxSize,
				encType, new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		if (files.hasMoreElements()) {
			String name = (String) files.nextElement();
			String fileName = multi.getFilesystemName(name);
			M_C_Contents=fileName;
		}
	} catch (Exception e) {
		out.print(e);
		out.print("예외 상황 발생..! ");
	}
	Date from = new Date();
	SimpleDateFormat transFormat = new SimpleDateFormat("yy-MM-dd");
	String M_C_Creator = request.getParameter("M_C_Creator");
	String M_C_Text = new String(request.getParameter("M_C_Text").getBytes("8859_1"),"utf-8");
	String M_C_Type = request.getParameter("M_C_Type");

	String M_C_lat=request.getParameter("lat");
	String M_C_lng=request.getParameter("lng");
	String M_C_Time = transFormat.format(from);

	Connection conn = null;
	Statement stmt = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/seongjun0926",
				"seongjun0926", "tjdwns3721");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();
		String command = String
				.format("insert into M_Create (M_C_Creator, M_C_Text, M_C_Contents, M_C_Type, M_C_lat, M_C_lng, M_C_Time) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s');",
						M_C_Creator, M_C_Text, M_C_Contents, M_C_Type,
						M_C_lat, M_C_lng,M_C_Time);

		int rowNum = stmt.executeUpdate(command);
		if (rowNum < 1)
			throw new Exception("데이터를 DB에 입력할 수 없습니다.");
	} finally {
		try {
			stmt.close();
		} catch (Exception ignored) {
		}
		try {
			conn.close();
		} catch (Exception ignored) {
		}
	}  
%>
