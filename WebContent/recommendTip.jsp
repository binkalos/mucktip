<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 팁</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="jquery.xdomainajax.js"></script>
<script src="js/weather_js.js"></script>
<script type="text/javascript">
    realTimeWeather();
</script>
</head>
<body>
<!-- Top --> 
<%@ include file="TopWrapper.jsp"%>
<!-- 날씨api받아오기 -->
 <div class="vis-weather">
        <h2 class="vh_hide">날씨정보</h2>
        <p class="weather-date"></p>
        <ul>
            <li class="weather-temp"></li>
            <li id="RN1">시간당강수량 : ?</li>
            <li class="weather-state-text"></li>
        </ul>
</div>	
<%@ include file="footer.jsp"%>
</body>
</html>