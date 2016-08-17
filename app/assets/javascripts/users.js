class User {

  constructor(id, email, diaries) {
    this.id = id;
    this.email = email;
    this.diaries = diaries;
  }
  printName() {
    return "User " + this.id + ": " + this.email;
  }

  diariesLength() {
    return this.diaries.length
  }
}

User.fromJSON = function (data) {
  var user = new User(data['id'], data['email'], data['diaries']);
  return user;
}

var bindShowUsersButton = function() {
  $(".users-list").on("click", function(e) {
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

var bindNextButton = function() {
  $(".js-next").on("click", function(e) {
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;
    $.get("/users/" + nextId + ".json", function(data) {
      var user = User.fromJSON(data);
      $(".userEmail").text(user.printName());
      $(".diaries").empty();
      $(".view-diaries").text("View All " + user.diariesLength() + " Diaries");
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

