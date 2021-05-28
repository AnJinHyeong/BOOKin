package semi.servlet.book;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@WebServlet(urlPatterns = "/bookadmin/savebook.kh")
public class SaveBook extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			resp.getWriter().println("책 추가중");
			Class.forName("oracle.jdbc.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","semiadmin","semiadmin");
			String sql = "select * from ( "
					+ "			 select rownum rn,tmp.* from  "
					+ "			       (select * from genre where genre_no>1000100 "
					+ "			  )tmp "
					+ "			) where rn between ? and ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(req.getParameter("start")));
			ps.setInt(2, Integer.parseInt(req.getParameter("end")));
			System.out.println(req.getParameter("start"));
			System.out.println(req.getParameter("end"));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Thread.sleep(200);
				long gerneNo = rs.getLong(2);
				System.out.println(gerneNo);
				List<String> list = new ArrayList<>();
				list.add("가");
				list.add("나");
				list.add("다");
				list.add("라");
				list.add("마");
				list.add("바");
				list.add("사");
				list.add("아");
				list.add("자");
				list.add("차");
				list.add("카");
				list.add("타");
				list.add("파");
				list.add("하");
				Collections.shuffle(list);
				for(int ii=0;ii<list.size()-10;ii++) {
					String keyword = list.get(ii);
					
					System.out.println(keyword);
					
					String text = URLEncoder.encode(keyword, "UTF-8");
					URL url;
					if(String.valueOf(gerneNo).startsWith("330")) {
						long gerneNo2=(long) (gerneNo/100);
						url = new URL("https://openapi.naver.com/v1/search/book_adv.xml?d_titl="+text+"&d_catg="+gerneNo2+"&display=10&start=1");
					}else {
						url = new URL("https://openapi.naver.com/v1/search/book_adv.xml?d_titl="+text+"&d_catg="+gerneNo+"&display=10&start=1");
					}
					HttpURLConnection con = (HttpURLConnection) url.openConnection();
					con.setRequestMethod("GET");
					
					con.setRequestProperty("X-Naver-Client-Id", "iFwSuBvTj1yuBGgQ_Ipn");
					con.setRequestProperty("X-Naver-Client-Secret", "92cIE7rOi9");
					con.setRequestProperty("Content-Type", "text/html");
					con.setRequestProperty("charset", "UTF-8");
					con.setRequestProperty("User-Agent", "curl/7.49.1");
					int responseCode = con.getResponseCode();
			        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			         
			        //2.빌더 생성
			        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			         
			        //3.생성된 빌더를 통해서 xml문서를 Document객체로 파싱해서 가져온다
				    Document doc = dBuilder.parse(con.getInputStream());
				  
				    doc.getDocumentElement().normalize();
				    Element root = doc.getDocumentElement();

				    NodeList n_list = root.getElementsByTagName("item");
				    Element el = null;
				    NodeList sub_n_list = null; //sub_n_list
			        Element sub_el = null; //sub_el
			         
			        Node v_txt = null;
			        String value="";
					
					String[] tagList = {"title", "image", "author","price","discount","publisher","description","pubdate"};
					for(int i=0; i<n_list.getLength(); i++) {
						List<String> dbList = new ArrayList<>();
						el = (Element) n_list.item(i);
						for(int k=0; k< tagList.length; k++) {
							sub_n_list = el.getElementsByTagName(tagList[k]);
							for(int j=0; j<sub_n_list.getLength(); j++) {
								sub_el = (Element) sub_n_list.item(j);
								v_txt = sub_el.getFirstChild();
								if(v_txt!=null) {
									value = v_txt.getNodeValue();
								}else {
									value="";
								}
								value=value.replaceAll("<b>", "");
								value=value.replaceAll("</b>", "");
//								System.out.println("book_"+sub_el.getNodeName() + "::::value="+value);
								
								dbList.add(value);
								if(sub_el.getAttributes().getNamedItem("id")!=null)
									System.out.println("id="+ sub_el.getAttributes().getNamedItem("id").getNodeValue() );
								
							}
						}
						System.out.println("book_genre:::value="+gerneNo);
						System.out.println(dbList);
						String sql2 = "insert into book values(book_seq.nextval,?,?,?,?,?,?,?,?,?)";
						PreparedStatement ps2 = conn.prepareStatement(sql2);
						ps2.setString(1, dbList.get(0));
						ps2.setString(2, dbList.get(1));
						ps2.setString(3, dbList.get(2));
						Integer b;
						if(dbList.get(3)=="") {
							b=0;
						}else {
							b=Integer.parseInt(dbList.get(3));
						}
						ps2.setInt(4, b);
						Integer a;
						if(dbList.get(4)=="") {
							a=0;
						}else {
							a=Integer.parseInt(dbList.get(4));
						}
						ps2.setInt(5,a);
						ps2.setString(6, dbList.get(5));
						ps2.setString(7, dbList.get(6));
						ps2.setString(8,dbList.get(7));
						ps2.setLong(9, gerneNo);
						
						ps2.executeQuery();
					}
				}
				}
			conn.close();
			resp.sendRedirect("adbookadd.jsp");
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("adbookadd.jsp");
		}
	}
}
