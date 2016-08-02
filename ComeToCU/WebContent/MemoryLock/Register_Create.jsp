<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="org.json.simple.*"%>

<%@ page import="Util.DB"%>


<%@ page import="java.awt.Graphics2D"%>
<%@ page import="java.awt.image.renderable.ParameterBlock"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="javax.media.jai.JAI"%>
<%@ page import="javax.media.jai.RenderedOp"%>
<%@ page import="javax.imageio.ImageIO"%>
 

<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"
	import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"
	import="java.util.*" import="java.io.*"%>

<%
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("UTF-8");
	String M_C_Contents = "12";
	String fileName="";
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

		String name = (String) files.nextElement();//파일 가져와서
		 fileName = multi.getFilesystemName(name);//파일 가져옴
		M_C_Contents = fileName;

	} catch (Exception e) {
		out.print(e);
		out.print("예외 상황 발생..! ");
	}
	
	ParameterBlock pb=new ParameterBlock(); //ParameterBlock클래스에 변환할 이미지를 담고 그 이미지를 불러옴
	 pb.add(realFolder+"/"+fileName);//방금 들어간 곳의 파일을 pb에 넣음
	 RenderedOp rOp=JAI.create("fileload",pb);
	 
	 BufferedImage bi= rOp.getAsBufferedImage();
	 BufferedImage thumb=new BufferedImage(500,500,BufferedImage.TYPE_INT_RGB);//100*100으로 지정
	 //BufferdImage 앞 두 숫자와 drawImage 뒤의 숫자가 같아야 사진이 올바르게 표시됨
	 Graphics2D g=thumb.createGraphics(); 
	 g.drawImage(bi,0,0,500,500,null); //정해진 버퍼사이즈에 맞춰서 드로우
	  File file=new File(realFolder+"/"+fileName);
	 ImageIO.write(thumb,"jpg",file); //저장타입을 jpg


	Date from = new Date();
	SimpleDateFormat transFormat = new SimpleDateFormat("yy-MM-dd");
	String M_C_Creator = request.getParameter("M_C_Creator");
	String M_C_Text = new String(request.getParameter("M_C_Text")
			.getBytes("8859_1"), "utf-8");//db에 글자 넣기 위해 인코딩
	String M_C_Type = request.getParameter("M_C_Type");
	String M_S_Persons=request.getParameter("M_S_Persons");
	String M_C_lat = request.getParameter("lat");
	String M_C_lng = request.getParameter("lng");
	String M_C_Time = transFormat.format(from);

	Connection conn = null;
	Statement stmt = null;
	Statement stmt1 = null;

	try {
		conn = DB.getConnection();
		if (conn == null){
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		}
		if(M_S_Persons==null||M_S_Persons.equals("null")){//공유사용자 추가 안되면
		stmt = conn.createStatement();
		String command = String
				.format("insert into M_Create (M_C_Creator, M_C_Text, M_C_Contents, M_C_Type, M_C_lat, M_C_lng, M_C_Time) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s');",
						M_C_Creator, M_C_Text, M_C_Contents, M_C_Type,
						M_C_lat, M_C_lng, M_C_Time);

		int rowNum = stmt.executeUpdate(command);
		if (rowNum < 1)
			throw new Exception("데이터를 DB에 입력할 수 없습니다.");
		}
		else{//추가되면
		

		stmt=conn.createStatement();
		stmt1=conn.createStatement();
		
		 stmt.executeUpdate("insert into M_Create (M_C_Creator,M_C_Text,M_C_Contents,M_C_Type,M_C_lat, M_C_lng, M_C_Time) value ( '"+M_C_Creator+"', '"+M_C_Text+"','"+M_C_Contents+"','"+M_C_Type+"' ,'"+M_C_lat+"', '"+M_C_lng+"', '"+M_C_Time+"');");
		 stmt.close();
		 
		 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, 
					ResultSet.CONCUR_UPDATABLE);
			
			ResultSet rs=stmt.executeQuery("select M_C_Num from M_Create where M_C_Creator='"+M_C_Creator+"';");
			int M_C_Num_=0;
			while(rs.next()){
				M_C_Num_=rs.getInt("M_C_Num"); //M_C_Num의 마지막 값을 가져옴 while 반복문을 사용해서.
			}
			rs.close();
			stmt.close();
		 
		 stmt1.executeUpdate("insert into M_Shared (M_S_Persons,M_S_FK) values ('"+M_S_Persons+"',"+M_C_Num_+");");
		 stmt1.close();
		} 
	} finally {
		try {
			stmt.close();
			stmt1.close();
		} catch (Exception ignored) {
		}
		try {
			conn.close();
		} catch (Exception ignored) {
		}
	}
%>
