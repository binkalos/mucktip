package javasrc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class APIServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 PrintWriter out = response.getWriter();
		 System.out.println(request.getParameter("nx"));
		 System.out.println(request.getParameter("ny"));
		 URL url = new URL("http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/"
		 		+ "ForecastSpaceData?ServiceKey=G%2FXxlCsyEV%2Fy3qKV5MCbpgrWJPwRHqCAzIpQc%2F%2B7nc3oiqK%2FhjtzefX40Dk6UEU4S7V280SjSRr0q4MYXMSQNQ%3D%3D"
		 		+ "&_type=json&base_date=20190611&base_time=0500&nx=60&ny=127&numOfRows=10&pageNo=1");
        URLConnection conn = url.openConnection();
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        InputStream is = conn.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        char[] buff = new char[512];
        int len = -1;
        
        String xml = "";
        while(true) {
        	String line = br.readLine();
        	if(line == null) break;
        	xml += line;
        
        }
        
        br.close();
		 
        out.println(xml);
		 
	}
}
