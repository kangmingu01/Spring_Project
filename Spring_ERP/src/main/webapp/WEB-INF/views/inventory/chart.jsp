<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="<c:url value="/css/reset.css"/>" type="text/css" rel="stylesheet">
  <link href="<c:url value="/css/chart.css"/>" type="text/css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1"></script>

<!-- Chart.js DataLabels Plugin -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

  <!-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <title>Document</title>
</head>
<body>
	<div class="content">
	    <!-- 바디부분 -->
	    <div class="content_body">
	      <!-- 서치 태그 -->
	      <div class="content_body_search">
	      	<!-- 월별 입출고 현황 -->
	        <div class="content_search_one">
	        	<div class="month_inout_title">월별 입출고 현황</div>
	        	<canvas id="monthChart"></canvas>
	        </div>
	        <!-- 년도 최고 매출 상품 Top5 -->
	       	<div class="item_sales_good">

	       	</div>
	        <!-- 현재 재고 -->
        	<div class="total_inventory">
        		<div class="inventory_title">총 재고 수량</div>
	        	<canvas id="inventoryChart" ></canvas>
        	</div>
	
		  </div>
		  <div class="content_body_list">
		      <div class="salesChart">
		      	<canvas id="salesChart"></canvas>
		      </div>	
		      <div class="warehouse_capacity">
		      	<div class="warehouse_header">	      	
					<select class="form-select"  id="warehouseSelect"></select> <!-- 창고 선택 박스 -->
					<div class="styOne">사용중인 용량</div>		      	
					<div class="styTwo">남은 용량</div>		      	
		      	</div>
		      	<div id="chartContainer"></div> <!-- 차트가 표시될 컨테이너 -->
		      </div>	  
		  </div>
	  	</div>
	</div>
	
	
	<script type="text/javascript">
	monthDisplay();
	display();
	salesDisplay();
	salesProductDisplay();
	warehouseDisplay();

	
	function warehouseDisplay() {
	    $.ajax({
	        type: "get",
	        url: "<c:url value='/inventory/inventory_warehouse_space'/>", 
	        dataType: "json",  		
	        success: function(result) {
	            console.log(result);  // 데이터를 콘솔에 출력하여 확인
	            populateWarehouseSelect(result);  // 창고 선택 박스에 목록 추가
	            warehouseChart(result);  // 전체 창고 차트 그리기
	        },
	        error: function(xhr) {
	            alert("데이터를 불러오는데 실패하였습니다.");
	        }
	    });
	}

	function populateWarehouseSelect(data) {
	    var select = document.getElementById('warehouseSelect');
	    select.innerHTML = '';  // 기존 옵션 초기화

	    // 기본 옵션 추가 (전체 보기)
	    var defaultOption = document.createElement('option');
	    defaultOption.value = '';
	    defaultOption.text = '보유 창고';
	    select.appendChild(defaultOption);

	    // 창고별 옵션 추가
	    data.forEach(item => {
	        var option = document.createElement('option');
	        option.value = item.WAREHOUSE_NAME;
	        option.text = item.WAREHOUSE_NAME;
	        select.appendChild(option);
	    });

	    // 선택이 변경될 때 차트 업데이트
	    select.addEventListener('change', function() {
	        var selectedWarehouse = this.value;
	        if (selectedWarehouse) {
	            // 특정 창고만 선택된 경우
	            const filteredData = data.filter(item => item.WAREHOUSE_NAME === selectedWarehouse);
	            warehouseChart(filteredData);
	        } else {
	            // 전체 창고 보기
	            warehouseChart(data);
	        }
	    });
	}

	function warehouseChart(data) {
	    const chartContainer = document.getElementById('chartContainer');
	    chartContainer.innerHTML = '';  // 기존 차트 제거

	    // 최대 4개의 창고만 처음에 표시
	    const maxChartsToShow = 4;
	    const initialData = data.slice(0, maxChartsToShow);  // 처음 4개 차트

	    // 처음 4개의 창고 차트를 생성
	    initialData.forEach(item => {
	        renderWarehouseChart(chartContainer, item);
	    });
	}

	// 창고별 차트를 생성하는 함수 (이전 createChart 함수를 renderWarehouseChart로 변경)
	function renderWarehouseChart(container, item) {
	    const canvas = document.createElement('canvas');
	    canvas.id = 'chart_' + item.WAREHOUSE_NAME;
	    canvas.style.width = '200px';
	    canvas.style.height = '180px';
	    container.appendChild(canvas);
	
	    const ctx = canvas.getContext('2d');
	    const chartData = [item.USED_CAPACITY, item.REMAINING_CAPACITY];
	    const backgroundColor = ['#6571FF', '#c0c0c0'];
	    const borderColor = ['#6571FF', '	#c0c0c0'];
	
	    new Chart(ctx, {
	        type: 'doughnut',
	        data: {
	            labels: [], // 라벨을 비워둡니다.
	            datasets: [{
	                data: chartData,
	                backgroundColor: backgroundColor,
	                borderColor: borderColor,
	                borderWidth: 1,
	                hoverOffset: 4
	            }]
	        },
	        options: {
	            responsive: false,
	            maintainAspectRatio: false,
	            cutout: '60%',
	            rotation: -90,
	            circumference: 180,
	            plugins: {
	                legend: {
	                    display: false, // 레전드 숨김
	                },
	                title: {
	                    display: true,
	                    text: item.WAREHOUSE_NAME, // 창고 이름을 제목으로 표시
	                    position: 'bottom', // 제목 위치를 하단으로 설정
	                    padding: {
	                        top: 0, // 제목과 차트 간의 간격
	                        bottom: 0 // 제목과 차트 간의 간격
	                    },
	                    font: {
	                        size: 14, // 글꼴 크기
	                        weight: 'bold', // 글꼴 두께
	                        family: 'Arial' // 글꼴 패밀리
	                    }
	                }
	            }
	        }
	    });
	}

    
	//최근 1년 최고 매출 상품
	function salesProductDisplay(){

		$.ajax({
    		type:"get",
    		url: "<c:url value="/inventory/inventory_sales_product"/>", 
			dataType: "json",  		
			success: function(result){
				console.log(result);	
				if(result.length == 0){
					var html="<div>검색된 상품이 없습니다.</div>";
					$(".item_sales_good").html(html);
					return;
				}
				var html="<div>최근 1년 최고 매출 상품</div>";
				$(result).each(function(){
					html+="<div class='productSty'>"
					html+="<div>상품명 : "+this.PRODUCT_NAME+"</div>";
					html+="<div>판매수량 : "+this.TOTAL_OUT_QUANTITY+"</div>";
					html+="</div>"
				});
				$(".item_sales_good").html(html);					
	        },
			error:function(xhr){
				alert("데이터를 불러오는데 실패 하였습니다.");
			}
    	});
		
	};
	
	
	//현재 보유하고있는 재고
	function display(){

		$.ajax({
    		type:"get",
    		url: "<c:url value="/inventory/inventory_chart"/>", 
			dataType: "json",  		
			success: function(result){
				console.log(result);
				createChart(result);	
	        },
			error:function(xhr){
				alert("데이터를 불러오는데 실패 하였습니다.");
			}
    	});
		
	};
	
	
	function createChart(data) {
	   
	    var productNames = data.map(item => item.productName);
	    var totalCurrentQtys = data.map(item => item.totalCurrentQty);
	    
	    var colorList = new Array();
	    for (var i = 0; i < data.length; i++) {
	        var d = data[i];
	        colorList.push(colorize());
	    }

	    var ctx = document.getElementById('inventoryChart').getContext('2d');
	    var inventoryChart = new Chart(ctx, {
	        type: 'doughnut', // 도넛 차트로 변경
	        data: {
	            labels: productNames,
	            datasets: [{
	                label: '현재수량',
	                data: totalCurrentQtys,
	                backgroundColor: colorList,
	                borderWidth: 1
	            }]
	        },
	        options: {
	            plugins: {
	                legend: {
	                    display: true, 
	                    position: 'right', 
	                    labels: {
	                        font: {
	                            size: 16 
	                        }
	                    }
	                },
	                tooltip: {
	                    bodyFont: {
	                        size: 14 
	                    }
	                }
	            },
	            cutout: '0%', // 도넛 차트 가운데 구멍의 크기 (퍼센트로 설정)
	            responsive: true,
	        },
	        plugins: [{
	            beforeDraw: function(chart) {
	                var width = chart.width,
	                    height = chart.height,
	                    ctx = chart.ctx;

	                ctx.restore(); // 복원

	               /*  // "총재고" 텍스트의 폰트 크기 설정
	                var titleFontSize = (height / 150).toFixed(2); 
	                ctx.font = titleFontSize + "em sans-serif";
	                ctx.textBaseline = "middle";

	                var totalInventory = totalCurrentQtys.reduce((sum, qty) => sum + qty, 0); // 총 재고 수 계산
	                var text = "총재고",
	                    countText = totalInventory.toString(), // 총재고 수를 문자열로 변환
	                   // textX = Math.round((width - ctx.measureText(text).width) / 2)-90, // 중앙 정렬
	                    textX = 70, // 중앙 정렬
	                    textY = height / 2 - 10; // 중앙에서 약간 위로 이동 (위치 조정)

	                ctx.clearRect(0, 0, width, height); // 이전 그리기 지우기
	                ctx.fillText(text, textX, textY); // 총재고 텍스트 그리기

	                // 총재고 수 텍스트의 폰트 크기 설정
	                var countFontSize = (height / 300).toFixed(2); // 더 작은 폰트 크기
	                ctx.font = countFontSize + "em sans-serif"; // 폰트 크기 변경
	                
	                // X 축 위치 조정 (10픽셀 오른쪽으로 이동)
	                var countTextX = textX + 40; // 조정할 값: 10 픽셀 오른쪽으로 이동
	                var countTextY = textY + 50; // "총재고" 텍스트 아래에 위치 (위치 조정)

	                ctx.fillText(countText, countTextX, countTextY); // 총재고 수 텍스트 그리기
	                ctx.save(); // 상태 저장 */
	            }
	        }]

	    });
	}
	
	//랜덤 색상부여
	function colorize() {
		var r = Math.floor(Math.random()*200);
		var g = Math.floor(Math.random()*200);
		var b = Math.floor(Math.random()*200);
		var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
		return color;
	}
	
	//월별 입출고 현황
	function monthDisplay(){

		$.ajax({
    		type:"get",
    		url: "<c:url value="/inventory/inventory_chartInOut"/>", 
			dataType: "json",  		
			success: function(result){
				console.log(result);
				monthChart(result);	
	        },
			error:function(xhr){
				alert("데이터를 불러오는데 실패 하였습니다.");
			}
    	});
	};	
	
	function monthChart(data) {
	    // 데이터 준비
	    const months = data.map(item => item.month);
	    const inQuantities = data.map(item => item.inQuantity);
	    const outQuantities = data.map(item => item.outQuantity);

	    const ctx = document.getElementById('monthChart').getContext('2d');
	    const inOutChart = new Chart(ctx, {
	        type: 'bar', // 차트 타입
	        data: {
	            labels: months,
	            datasets: [
	                {
	                    label: '입고',
	                    data: inQuantities,
	                    backgroundColor: '#6571FF',
	                    borderColor: '#0033FF',
	                    borderWidth: 1
	                },
	                {
	                    label: '출고',
	                    data: outQuantities,
	                    backgroundColor: '#FF6600',
	                    borderColor: '#FF6600',
	                    borderWidth: 1
	                }
	            ]
	        },
	        options: {
	            scales: {
	                y: {
	                    beginAtZero: true,
	                    title: {
	                        display: false,
	                        text: '수량'
	                    },
	                    grid: {
	                        display: false // y축 그리드 라인 숨기기
	                    }
	                },
	                x: {
	                    title: {
	                        display: false,
	                        text: '월별'
	                    }
	                }
	            }
	        }
	    });
	}
	
	function salesDisplay() {
	    $.ajax({
	        type: "get",
	        url: "<c:url value='/inventory/inventory_sales'/>", // 매출 데이터 요청 URL
	        dataType: "json",
	        success: function (result) {
	            console.log(result);
	            salesChart(result);
	        },
	        error: function (xhr) {
	            alert("데이터를 불러오는데 실패 하였습니다.");
	        }
	    });
	}

	function salesChart(data) {

	    var months = data.map(item => item.MONTH);
	    var totalCosts = data.map(item => item.TOTAL_COST);
	    var totalRevenues = data.map(item => item.TOTAL_REVENUE);

	    var ctx = document.getElementById('salesChart').getContext('2d');
	    
	
	    var gradientCost = ctx.createLinearGradient(0, 0, 0, 400);
	    gradientCost.addColorStop(0, 'rgba(75, 192, 192, 0.6)');
	    gradientCost.addColorStop(1, 'rgba(75, 192, 192, 0.1)');
	    
	
	    var gradientRevenue = ctx.createLinearGradient(0, 0, 0, 400);
	    gradientRevenue.addColorStop(0, 'rgba(153, 102, 255, 0.6)');
	    gradientRevenue.addColorStop(1, 'rgba(153, 102, 255, 0.1)');

	    var inventoryChart = new Chart(ctx, {
	        type: 'line', // 곡선형 라인 차트
	        data: {
	            labels: months,
	            datasets: [
	                {
	                    label: '총 지출 금액',
	                    data: totalCosts,
	                    backgroundColor: gradientCost,
	                    borderColor: 'rgba(75, 192, 192, 1)',
	                    borderWidth: 2,
	                    fill: true, // 그래디언트를 표시하기 위해 true로 설정
	                    tension: 0.4 // 곡선형 차트를 위한 tension 값
	                },
	                {
	                    label: '총 수익 금액',
	                    data: totalRevenues,
	                    backgroundColor: gradientRevenue,
	                    borderColor: 'rgba(153, 102, 255, 1)',
	                    borderWidth: 2,
	                    fill: true,
	                    tension: 0.4
	                }
	            ]
	        },
	        options: {
	            responsive: true,
	            scales: {
	                y: {
	                    beginAtZero: true,
	                    title: {
	                        display: true,
	                        text: '금액 (원)' // Y축 제목
	                    }
	                }
	            },
	            plugins: {
	                legend: {
	                    display: true,
	                    position: 'top',
	                    labels: {
	                        font: {
	                            size: 16
	                        }
	                    }
	                },
	                tooltip: {
	                    enabled: true, // 툴팁 활성화
	                    mode: 'index', // 데이터 포인트를 강조
	                    intersect: false, 
	                    bodyFont: {
	                        size: 14
	                    }
	                }
	            }
	        }
	    });
	}
	
	
	
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
	