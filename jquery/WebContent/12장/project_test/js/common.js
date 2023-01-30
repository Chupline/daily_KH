$(function () {
  /* 1. 로그인 버튼*/
  // 로그인 창 띄우기
  $(".login_wrap > a").on("click", function () {
    $("#login_f").animate({ top: "20px" }, 500);
    return false;
  })
  // close, 로그인 버튼을 눌렀을때 로그인창 닫기
  $(".login_close_btn, input[alt = '로그인버튼']").on("click", function () {
    $("#login_f").animate({ top: "-500px" }, 500);
    return false;
  })
  // focus : 클릭 시 입력창 강조  
  $("#user_id, #user_pw").on("focus", function () {
    $(this).prev().css("left", "-9999px"); // prev() : #user_id (input 태그 위) -> label태그 
  })
  // blur : label 밖 클릭시 원상복귀 및 입력값은 그대로 보이기
  $("#user_id, #user_pw").on("blur", function () {
    if ($(this).val() == "")
      $(this).prev().css("left", "2px");
  })

  /* 2. zoom 버튼*/
  var base = 100;
  var mybody = $("body"); // 전체 body 태그
  // + 클릭시 zoom in 
  $("#zoom a").on("click", function () {
    var zNum = $("#zoom a").index(this);
    if (zNum == 0) {        // "+"
      base += 10;
    } else if (zNum == 1) { // "100"
      base = 100;
    } else {                // "-"
      base -= 10;
    }
    mybody.css("overflow-x", "auto")
      .css("transform-origin", "0 0")
      .css("transform", "scale(" + base / 100 + ")") //css("transform", "scale(1)")
      .css("zoom", base + "%"); //css("zoom", 100%)
    return false;
  })

  /* 3. 프린트 버튼*/
  $(".print_btn").on("click", function () {
    window.print();
    return false;
  })

  /* 4. 검색 창 안내 가이드*/
  $("#keyword").on("focus", function () {
    $(this).css("background-position", "0 -500px");
  }).on("blur", function () {
    if ($(this).val() == "") // 값이 비어있을때만 blur
      $(this).css("background-position", "0 0");
  })

  /* 5. GNB메뉴*/
  var beforeEl;
  $("#gnb > li > a").on("mouseover focus", function () {
    if (beforeEl) // 맨처음 스킵된다.
      beforeEl.children("img").attr("src", beforeEl.children("img").attr("src").replace("over.gif", "out.gif"));
    $("#gnb ul:visible").slideUp("fast");

    $("img", this).attr("src", $("img", this).attr("src").replace("out.gif", "over.gif")); // this: images/gnb_1_out.gif

    $(this).next().stop().slideDown("normal"); //this : a

    beforeEl = $(this);
  })

  $("#gnb > li > a").on("mouseleave", function () {
    $("#gnb ul:visible").slideUp("fast");
    if(beforeEl)
      beforeEl.children("img").attr("src", beforeEl.children("img").attr("src").replace("over.gif","out.gif"));
  })

  /* 6. 전체메뉴*/
  $("#total_btn a").on("click", function() {
    $("#total_menu").slideDown("normal");
    $("img", this).attr("src", $("img", this).attr("src").replace("out.gif", "over.gif")); // 자기 밑에 있는 이미지
    return false;
  })
  
  /* 7. 전체 메뉴 닫기 버튼*/
  $("#total_close a").on("click", function() {
    $("#total_menu").slideUp("fast");
    $("#total_btn a img").attr("src", $("#total_btn a img").attr("src").replace("over.gif", "out.gif"));
    return false;
  })

  /* 8. 날짜 표기*/
  var t = new Date();
  var y = t.getFullYear();
  var m = t.getMonth();
  var d = t.getDate();

  $("#date_wrap .year").text(y);
  $("#date_wrap .month").text(m+1);
  $("#date_wrap .date").text(d);

  /* 9. 관련 사이트 이동*/


  /* 10. 퀵메뉴*/

});