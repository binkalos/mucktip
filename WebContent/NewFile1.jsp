<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날씨</title>
    <style>
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="js/jquery.xdomainajax.js"></script>
</head>
<body>
    <div id="content"></div>
    <script>
    function getLocation(){
        if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition(locationSuccess, locationError, geo_options);
        }else{
            console.log("지오 로케이션 없음")
        }
    };
    // getLocation

    function locationSuccess(p){
            var latitude = p.coords.latitude,
            longitude = p.coords.longitude;
            var rs = dfs_xy_conv("toXY",latitude,longitude);
            // 위도/경도 -> 기상청 좌표x / 좌표 y 변환
            xml2jsonCurrentWth(rs.nx, rs.ny);
        }
    // locationSuccess

     function locationError(error){
            var errorTypes = {
                0 : "무슨 에러냥~",
                1 : "허용 안눌렀음",
                2 : "위치가 안잡힘",
                3 : "응답시간 지남"
            };
            var errorMsg = errorTypes[error.code];
            console.log(errorMsg)
        }
        // locationError

        var geo_options = {
            enableHighAccuracy: true,
            maximumAge        : 30000,
            timeout           : 27000
        };
        // geo_options
    // LCC DFS 좌표변환을 위한 기초 자료
        //
        var RE = 6371.00877; // 지구 반경(km)
        var GRID = 5.0; // 격자 간격(km)
        var SLAT1 = 30.0; // 투영 위도1(degree)
        var SLAT2 = 60.0; // 투영 위도2(degree)
        var OLON = 126.0; // 기준점 경도(degree)
        var OLAT = 38.0; // 기준점 위도(degree)
        var XO = 43; // 기준점 X좌표(GRID)
        var YO = 136; // 기1준점 Y좌표(GRID)
        //
        // LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
        //
    function dfs_xy_conv(code, v1, v2) {
        var DEGRAD = Math.PI / 180.0;
        var RADDEG = 180.0 / Math.PI;

        var re = RE / GRID;
        var slat1 = SLAT1 * DEGRAD;
        var slat2 = SLAT2 * DEGRAD;
        var olon = OLON * DEGRAD;
        var olat = OLAT * DEGRAD;

        var sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
        var sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
        var ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
        ro = re * sf / Math.pow(ro, sn);
        var rs = {};
        if (code == "toXY") {

            rs['lat'] = v1;
            rs['lng'] = v2;
            var ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
            ra = re * sf / Math.pow(ra, sn);
            var theta = v2 * DEGRAD - olon;
            if (theta > Math.PI) theta -= 2.0 * Math.PI;
            if (theta < -Math.PI) theta += 2.0 * Math.PI;
            theta *= sn;
            rs['nx'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
            rs['ny'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
        }
        else {
            rs['nx'] = v1;
            rs['ny'] = v2;
            var xn = v1 - XO;
            var yn = ro - v2 + YO;
            ra = Math.sqrt(xn * xn + yn * yn);
            if (sn < 0.0) - ra;
            var alat = Math.pow((re * sf/ ra), (1.0/ sn));
            alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

            if (Math.abs(xn) <= 0.0) {
                theta = 0.0;
            }
            else {
                if (Math.abs(yn) <= 0.0) {
                    theta = Math.PI * 0.5;
                    if (xn < 0.0) - theta;
                }
                else theta = Math.atan2(xn, yn);
            }
            var alon = theta / sn + olon;
            rs['lat'] = alat * RADDEG;
            rs['lng'] = alon * RADDEG;
        }
        return rs;
    }
    // dfs_xy_conv
    function xml2jsonCurrentWth(nx, ny){
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1;
        var yyyy = today.getFullYear();
        var hours = today.getHours();
        var minutes = today.getMinutes();
        console.log("time " + minutes)

        if(minutes < 30){
            // 30분보다 작으면 한시간 전 값
            hours = hours - 1;
            if(hours < 0){
                // 자정 이전은 전날로 계산
                today.setDate(today.getDate() - 1);
                dd = today.getDate();
                mm = today.getMonth()+1;
                yyyy = today.getFullYear();
                hours = 23;
            }
        }
        if(hours<10) {
            hours='0'+hours
        }
        if(mm<10) {
            mm='0'+mm
        }
        if(dd<10) {
            dd='0'+dd
        } 

        var _nx = nx,
        _ny = ny,
        apikey = "G%2FXxlCsyEV%2Fy3qKV5MCbpgrWJPwRHqCAzIpQc%2F%2B7nc3oiqK%2FhjtzefX40Dk6UEU4S7V280SjSRr0q4MYXMSQNQ%3D%3D  ",
        today = yyyy+""+mm+""+dd,
        basetime = hours + "00",
        fileName = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService/ForecastGrib";
        fileName += "?ServiceKey=" + apikey;
        fileName += "&base_date=" + today;
        fileName += "&base_time=" + basetime;
        fileName += "&nx=" + _nx + "&ny=" + _ny;
        fileName += "&pageNo=1&numOfRows=6";
        fileName += "&_type=json";

        $.ajax({
        url: fileName,
        type: 'GET',
        cache: false,
        success: function(data) {
            var myXML = rplLine(data.responseText);
            console.log(myXML)
            var indexS = myXML.indexOf('"body":{"items":{'),
                indexE = myXML.indexOf("}]}"),
                result = myXML;
//                result = myXML.substring(indexS, indexE);
            var jsonObj = $.parseJSON('[' + result + ']'),
                rainsnow = jsonObj[0].response.body.items.item[0].obsrValue,
                sky = jsonObj[0].response.body.items.item[4].obsrValue,
                temp = jsonObj[0].response.body.items.item[5].obsrValue;
                var contentText = document.getElementById('content');
            contentText.innerHTML = "하늘 상태 : " + sky + " / 눈 비 상태 : " + rainsnow + " / 온도 : " + temp;
        },
        error:function(request,status,error){
            alert("다시 시도해주세요.\n" + "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
        });

    }
    // xml2jsonCurrentWth

    function rplLine(value){
        if (value != null && value != "") {
            value = value.replace(/\n/g, "");
            value = value.replace(/<html>/g, "");
            value = value.replace(/<head>/g, "");
            value = value.replace(/<head\/>/g, "");
            value = value.replace(/<body>/g, "");
            value = value.replace(/<\/body><\/html>/g, "");
//            value = value.replace(/<html\/>/g, "");
        }
            return value;
    }
    // rplLine
    getLocation();
    </script>
</body>
</html>