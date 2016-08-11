<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<%@ page import="java.awt.Graphics2D"%>
<%@ page import="java.awt.image.renderable.ParameterBlock"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="javax.media.jai.JAI"%>
<%@ page import="javax.media.jai.RenderedOp"%>
<%@ page import="javax.imageio.ImageIO"%>

<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>

<%
String return1="";
String return2="";
String return3="";
//ë³ê²½ title íê·¸ìë ìë³¸ íì¼ëªì ë£ì´ì£¼ì´ì¼ íë¯ë¡
String name = "";
if (ServletFileUpload.isMultipartContent(request)){
	ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
	uploadHandler.setHeaderEncoding("UTF-8");
	List<FileItem> items = uploadHandler.parseRequest(request);
	for (FileItem item : items) {
		if(item.getFieldName().equals("callback")) {
			return1 = item.getString("UTF-8");
		} else if(item.getFieldName().equals("callback_func")) {
			return2 = "?callback_func="+item.getString("UTF-8");
		} else if(item.getFieldName().equals("Filedata")) {
			if(item.getSize() > 0) {
				//String name = item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
                // ê¸°ì¡´ ìë¨ ì½ëë¥¼ ë§ê³  íë¨ì½ëë¥¼ ì´ì©
                name = item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
				String filename_ext = name.substring(name.lastIndexOf(".")+1);
				filename_ext = filename_ext.toLowerCase();
			   	String[] allow_file = {"jpg","png","bmp","gif"};
			   	int cnt = 0;
			   	for(int i=0; i<allow_file.length; i++) {
			   		if(filename_ext.equals(allow_file[i])){
			   			cnt++;
			   		}
			   	}
			   	if(cnt == 0) {
			   		return3 = "&errstr="+name;
			   	} else {
			   		
			   		//íì¼ ê¸°ë³¸ê²½ë¡
		    		String dftFilePath = request.getServletContext().getRealPath("/");
		    		//íì¼ ê¸°ë³¸ê²½ë¡ _ ìì¸ê²½ë¡
		    		String filePath = dftFilePath + "UpLoad" + File.separator +"ComeToCU_UpLoad" + File.separator;
		    		
		    		File file = null;
		    		file = new File(filePath);
		    		if(!file.exists()) {
		    			file.mkdirs();
		    		}
		    		
		    		String realFileNm = "";
		    		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
					String today= formatter.format(new java.util.Date());
					realFileNm = today+UUID.randomUUID().toString() + name.substring(name.lastIndexOf("."));
					
					String rlFileNm = filePath + realFileNm;
					///////////////// ìë²ì íì¼ì°ê¸° ///////////////// 
					InputStream is = item.getInputStream();
					OutputStream os=new FileOutputStream(rlFileNm);
					int numRead;
					byte b[] = new byte[(int)item.getSize()];
					while((numRead = is.read(b,0,b.length)) != -1){
						os.write(b,0,numRead);
						
						Image a= new ImageIcon(rlFileNm).getImage();
						
						int imgWidth = a.getHeight(null);
						int imgHeigh = a.getWidth(null);
						
						if(imgWidth>601){
							
							int Width=600;
							int Heigh=imgHeigh*Width/imgWidth;
							
							ParameterBlock pb=new ParameterBlock(); //ParameterBlock클래스에 변환할 이미지를 담고 그 이미지를 불러옴
							 pb.add(rlFileNm);//방금 들어간 곳의 파일을 pb에 넣음
							 RenderedOp rOp=JAI.create("fileload",pb);
							 
							 BufferedImage bi= rOp.getAsBufferedImage();
							 BufferedImage thumb=new BufferedImage(Heigh,Width,BufferedImage.TYPE_INT_RGB);//100*100으로 지정
							 //BufferdImage 앞 두 숫자와 drawImage 뒤의 숫자가 같아야 사진이 올바르게 표시됨
							 Graphics2D g=thumb.createGraphics(); 
							 g.drawImage(bi,0,0,Heigh,Width,null); //정해진 버퍼사이즈에 맞춰서 드로우
							  File file1=new File(rlFileNm);
							 ImageIO.write(thumb,"jpg",file1); //저장타입을 jpg 
						}
						
						
						
					}
					if(is != null) {
						is.close();
					}
					os.flush();
					os.close();
					///////////////// ìë²ì íì¼ì°ê¸° /////////////////
		    		
		    		return3 += "&bNewLine=true";
                                // img íê·¸ì title ìµìì ë¤ì´ê° ìë³¸íì¼ëª
		    		return3 += "&sFileName="+ name;
		    		return3 += "&sFileURL=/UpLoad/ComeToCU_UpLoad/"+realFileNm;
			   	}
			}else {
				  return3 += "&errstr=error";
			}
		}
	}
}
response.sendRedirect(return1+return2+return3);
 %>