var bindNextButton = function() {
  $(".js-next").on("click", function(e) {
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;
    $.get("/users/" + nextId + ".json", function(data) {
      var name = "User" + data['id'] + ": " + data['email'];
      $(".userEmail").text(name);
      $(".diaries").empty();
      $(".view-diaries").text("View All " + data['diaries'].length + " Diaries");
      // re-set the id to current on the link
      $(".js-next").attr("data-id", data["id"]);
    });
    e.preventDefault();
  });
};

var bindShowDiaryButton = function() {
   $(".view-diaries").on("click", function(e) {
    var id = parseInt($(".js-next").attr("data-id"));
    $(".diaries").empty();
    $.get("/users/" + id + ".json", function(data) {
      var diaries = data['diaries'];
      $.each(diaries, function(i, v) {
        var html = "<li><a href='/diaries/" + v['id'] +"'>" +  v['created_at'] + "</a></li>";
        $('.diaries').append(html);
      })
    });
    e.preventDefault();
  });

};

var bindUserClickEvents = function() {
  bindNextButton();
  bindShowDiaryButton();
};
