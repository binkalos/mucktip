<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한식</title>
<link rel="stylesheet" href="whatToEatStyle.css" >
<link rel="stylesheet" href="mapStyle.css" >
<link rel="shortcut icon" href="/path/favicon.ico">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://cdn.sobekrepository.org/includes/jquery-rotate/2.2/jquery-rotate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<script>
(function($) {
	$.fn.extend({

		roulette: function(options) {

			var defaults = {
				angle: 0,
				angleOffset: -45,
				speed: 5000,
				easing: "easeInOutElastic",
			};

			var opt = $.extend(defaults, options);

			return this.each(function() {
				var o = opt;

				var data = [
					{ color: '#e6471d', text: '된장찌개' },
					{ color: '#be107f', text: '김치찌개' },
					{ color: '#f7a416', text: '순두부찌개' },
					{ color: '#efe61f', text: '미역국' },
					{ color: '#dc0936', text: '뼈해장국' },
					{ color: '#efe61f', text: '순대국' },
					{ color: '#f7a416', text: '부대찌개' },
					{ color: '#e6471d', text: '제육볶음' },
					{ color: '#dc0936', text: '낙지볶음' },
					{ color: '#e5177b', text: '닭도리탕' },
					{ color: '#be107f', text: '칼국수' },
					{ color: '#881f7e', text: '낙지볶음' }
				];

				var $wrap = $(this),
						$btnStart = $wrap.find("#btn-start"),
						$roulette = $wrap.find(".roulette"),
						wrapW = $wrap.width(),
						angle = o.angle,
						angleOffset = o.angleOffset,
						speed = o.speed,
						esing = o.easing,
						itemSize = data.length,
						itemSelector = "item",
						labelSelector = "label",
						d = 360 / itemSize,
						borderTopWidth = wrapW,
						borderRightWidth = tanDeg(d);

				for(i=1; i<=itemSize; i+=1){
					var idx = i-1,
							rt = i*d + angleOffset,
							itemHTML = $('<div class="'+ itemSelector +'">'),
							labelHTML = '';
							labelHTML += '<p class="'+ labelSelector +'">';
							labelHTML += '	<span class="text">'+ data[idx].text +'</span>';
							labelHTML += '</p>';

					$roulette.append(itemHTML);
					$roulette.children("."+ itemSelector).eq(idx).append(labelHTML);
					$roulette.children("."+ itemSelector).eq(idx).css({
						"left": wrapW / 2,
						"top": -wrapW / 2,
						"border-top-width": borderTopWidth,
						"border-right-width": borderRightWidth,
						"border-top-color": data[idx].color,
						"transform": "rotate("+ rt + "deg)"
					});

					var textH = parseInt(((2*Math.PI*wrapW)/d)*.5);

					$roulette.children("."+ itemSelector).eq(idx).children("."+ labelSelector).css({
						"height": textH+'px',
						"lineHeight": textH+'px',
						"transform": 'translateX('+  (textH*1.3) +'px) translateY('+ (wrapW*-.3) +'px) rotateZ('+ (90 + d*.5) +'deg)'
						                               //글자 각도
					});

				}

				function tanDeg(deg) {
					var rad = deg * Math.PI/180;
					return wrapW/(1/Math.tan(rad));
				}


				$btnStart.on("click", function() {
					rotation();
				});

				function rotation() {

					var completeA = 360 * r(5, 10) + r(0, 360);

					$roulette.rotate({
						angle: angle,
						animateTo: completeA,
						center: ["50%", "50%"],
						easing: $.easing.esing,
						callback: function() {
							var currentA = $(this).getRotateAngle();

							console.log(currentA);
							
						},
						duration: speed
					});
				}

				function r(min, max) {
					return Math.floor(Math.random() * (max - min + 1)) + min;
				}

			});
		}
	});
})(jQuery);

$(function() {

	$('.box-roulette').roulette();

});

</script>
</head>
<body>
<!-- Top -->
<%@ include file="TopWrapper.jsp"%>

<div class="main-content">
	<p class="title"><b>한식을 고른 당신 오늘 뭐 먹을래?</b></p>
	
	<div class="box-roulette">
		<div class="markers"></div>
		<button type="button" id="btn-start">
			돌려 돌려<br>돌림판
		</button>
		<div class="roulette" id="roulette"></div>
	</div>
</div>
	<div class="chinese-map">
		<p class="title2">내 주변 한식맛집 찾기</p>
		<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="미림여자정보과학고 주변 한식" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7e0762dc22ba650124c959074cc14e7f&libraries=services"></script>
<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === daum.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === daum.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === daum.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new daum.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new daum.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            daum.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            daum.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new daum.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
</script>
	</div>
<%@ include file="footer.jsp"%>
</body>
</html>