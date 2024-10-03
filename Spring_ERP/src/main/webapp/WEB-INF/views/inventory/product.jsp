<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="<c:url value="/css/reset.css"/>" type="text/css" rel="stylesheet">
  <link href="<c:url value="/css/product.css"/>" type="text/css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <title>Document</title>
</head>
<body>
  <div class="content">
    <!-- 헤더부분 -->
    <div class="content_header">
      <div class="content_header_title">상품등록</div>
      <div class="content_header_btn">
        <div class="content_header_search_btn">
          <div><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
          </svg></div>
          <span>조회</span>
        </div>
        <div class="content_header_reset_btn">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
            <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
          </svg>
          <span>초기화</span>
        </div>
      </div>
    </div>
    <!-- 바디부분 -->
    <div class="content_body">
      <!-- 서치 태그 -->
      <div class="content_body_search">
        <!-- 서치 1row부분 -->
        <div>
          <div class="item_code">
            <label>제품코드</label>
            <input type="text" name="productId" class="result" readonly />
          </div>
          <div>
            <label>제품명</label>
            <input type="text" name="productName" class="productName"/>
          </div>
          <div class="item_brand">
            <label>브랜드</label>
            <input type="text" name="productBrand" class="productBrand"/>
          </div>
          <div></div>
          <div class="item_code_create">
            <button>이미지파일</button>
          </div>
        </div>
        <!-- 서치 2row 부분 -->
        <div>
          <div>
            <label>종류</label>
            <select class="category_item">
              <option value="" disabled selected ></option>
              <option>Sneakers&#40;운동화&#41;</option>
              <option>Slippers&#40;슬리퍼&#41;</option>
              <option>Boots&#40;부츠&#41;</option>
              <option>Sandals&#40;샌들&#41;</option>
              <option>Dress&nbsp;shoes&#40;구두&#41;</option>
            </select>
          </div>
          <div>
            <label>색상</label>
            <select class="category_color">
              <option value="" disabled selected ></option>
              <option>Red</option>
              <option>Blue</option>
              <option>Black</option>
              <option>White</option>
            </select>
          </div>
          <div>
            <label>사이즈</label>
            <select class="category_size" >
              <option value="" disabled selected ></option>
              <option>220</option>
              <option>230</option>
              <option>240</option>
              <option>250</option>
              <option>260</option>
              <option>270</option>
              <option>280</option>
              <option>290</option>
            </select>
          </div>
          <div>
            <label>성별</label>
            <select class="category_gender">
              <option value="" disabled selected ></option>
              <option>Man&#40;남자&#41;</option>
              <option>Woman&#40;여자&#41;</option>
            </select>
          </div>
          <div class="item_code_create">
            <button type="button" class="product_code_create">제품코드생성</button>
          </div>
        </div>
        <!-- 서치 3row 부분 -->
        <div>
          <div>
            <label>입고가격</label>
            <input type="text" name="productPrice" class="productPrice"/>
          </div>
          <div>
            <label>출고가격</label>
            <input type="text" name=deliveryPrice class="deliveryPrice"/>
          </div>
          <div></div>
          <div></div>
          <div class="item_code_create">
            <button>상품등록</button>
          </div>
        </div>
      </div>
      <!-- 추가사항 태그 -->
      <div class="content_body_search_plus">
        <div>창고 등록</div>
        <div>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
            <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
          </svg>
        </div>
      </div>
      <!-- 추가 on 부분 -->
      <div class="content_plus">
        <div>
          <div>
            <label>창고명</label>
            <input type="text" name="inventroyName" class="inventroyName"/>
          </div>
          <div>
            <label>위치</label>
            <input type="text" name="inventroyLocation" class="inventroyLocation"/>
          </div>
          <div>
            <label>창고용량</label>
            <input type="text" name="inventroyVolume" class="inventroyVolume"/>
          </div>
          <div></div>
          <div class="item_code_create">
            <button type="button" class="inventroy_create">창고등록</button>
          </div>
        </div>
        <div></div>
      </div>
      <!-- 엑셀 업로드 다운로드 부분 -->
      <div class="file_btn">
        <div class="upload_btn">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-upload" viewBox="0 0 16 16">
              <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
              <path d="M7.646 1.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 2.707V11.5a.5.5 0 0 1-1 0V2.707L5.354 4.854a.5.5 0 1 1-.708-.708z"/>
            </svg>
            <span>UPLOAD</span>
          </div>
        </div>
        <div class="excel_btn">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
              <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
              <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
            </svg>
            <span>EXCEL</span>
          </div>
        </div>
      </div>
      <!-- 테이블 부분 -->
      <div class="content_body_list">
        <table>
          <thead>
              <tr>
                  <th>제품코드</th>
                  <th>제품명</th>
                  <th>브랜드</th>
                  <th>색상</th>
                  <th>사이즈</th>
                  <th>종류</th>
                  <th>성별</th>
                  <th>입고가격</th>
                  <th>출고가격</th>
                  <th style="width: 100px;"></th>
              </tr>
          </thead>
          <tbody class="sty">
              <tr>
                  <td>SLREM220</td>
                  <td>AIR</td>
                  <td>나이키</td>
                  <td>Black</td>
                  <td>270</td>
                  <td>운동화</td>
                  <td>남자</td>
                  <td>1,000원</td>
                  <td>1,500,000원</td>
                  <td><button>수정</button><button>삭제</button></td>
              </tr>
              <tr>
                  <td>SLREM220</td>
                  <td>NB992</td>
                  <td>뉴발란스</td>
                  <td>Black</td>
                  <td>270</td>
                  <td>운동화</td>
                  <td>남자</td>
                  <td>10</td>
                  <td>1,200,000원</td>
                  <td><button>수정</button><button>삭제</button></td>
              </tr>
              <tr>
                  <td>SLREM220</td>
                  <td>삼바</td>
                  <td>아디다스</td>
                  <td>Black</td>
                  <td>270</td>
                  <td>운동화</td>
                  <td>남자</td>
                  <td>10</td>
                  <td>700,000원</td>
                  <td><button>수정</button><button>삭제</button></td>
              </tr>
              <tr>
                  <td>SLREM220</td>
                  <td>젤 카야노</td>
                  <td>아식스</td>
                  <td>Black</td>
                  <td>270</td>
                  <td>운동화</td>
                  <td>남자</td>
                  <td>10</td>
                  <td>300,000원</td>
                  <td><button>수정</button><button>삭제</button></td>
              </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <script>
    // 추가 정보 클릭 이벤트
    var plusBtn=document.querySelector(".content_body_search_plus");
    var plusContent=document.querySelector(".content_plus");
    plusBtn.addEventListener("click",function(){
      if(plusBtn.className=="content_body_search_plus"){
        plusBtn.classList.add("on");
        plusContent.classList.add("on");
      }else{
        plusBtn.classList.remove("on");
        plusContent.classList.remove("on");
      }
    });

    //제품등록 text 초기화 함수
    function init(){
        document.querySelector(".productName").value="";
        document.querySelector(".productBrand").value="";
        document.querySelector(".productPrice").value="";
        document.querySelector(".deliveryPrice").value="";
        document.querySelector(".result").value="";
        document.querySelector(".category_item").value="";
        document.querySelector(".category_color").value="";
        document.querySelector(".category_size").value="";
        document.querySelector(".category_gender").value="";
        document.querySelector(".inventroyName").value="";
        document.querySelector(".inventroyVolume").value="";
        document.querySelector(".inventroyLocation").value="";
        
    }
    //초기화 클릭 이벤트
    document.querySelector(".content_header_reset_btn").addEventListener("click",function(){
      init();
    });

    //제품코드 자동 완성 함수
    function codeCreate(){
      var item=document.querySelector('.category_item').value.slice(0, 2);
      var color=document.querySelector('.category_color').value.slice(0, 2);
      var size=document.querySelector('.category_size').value;
      var gender=document.querySelector('.category_gender').value.charAt(0);
      console.log(item);
      console.log(color);
      console.log(size);
      console.log(gender);
      var result = `${item}${color}${size}${gender}`;
      document.querySelector('.result').value = result;
    }

    //제품코드 클릭 이벤트
    document.querySelector(".product_code_create").addEventListener("click",function(){
      codeCreate();
    });


  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>