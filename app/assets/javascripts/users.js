// function Animal (name) {
//   this.name = name;  
// }
// Animal.prototype.speak = function () {
//   console.log(this.name + ' makes a noise.');
// }


function User(id, email, diaries) {
  this.id = id;
  this.email = email;
  this.diaries = diaries;
}

User.prototype.printName = function() {
  return "User " + this.id + ": " + this.email;
}

User.prototype.diariesLength = function() {
  return this.diaries.length
}


User.fromJSON = function (data) {
  var user = new User(data['id'], data['email'], data['diaries']);
  return user;
}

var bindShowUsersButton = function() {
  $(".view-users").on("click", function(e) {
    $(".users-list").empty();
    $.get("/users.json", function(data) {
      $.each(data, function(i, v) {
        var user = User.fromJSON(v);
        var html = "<li><a href='/users/" + user.id +"'>" +  user.printName() + "</a></li>";
        $('.users-list').append(html);
      })
    });
    e.preventDefault();
  });
};

var bindNextButton = function() {
  $(".js-next").on("click", function(e) {
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;
    if (nextId > parseInt($(".js-next").attr("data-last"))) {
      nextId = 1;
    }
    $.get("/users/" + nextId + ".json", function(data) {
      var user = User.fromJSON(data);
      $(".userEmail").text(user.printName());
      $(".diaries").html('<li>...</li>');
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

