 
class Entry {
  constructor(data) {
    this.id = data['id'];
    this.day = data['day'];
    this.hours = data['minutes']/60.0;
    this.project = data['project']['name'];
  }
  makeHTML() {
    var html = "<tr>"
    html += "<td>" + this.project + "</td>";
    html += "<td>" + this.day + "</td>";
    html += "<td>" + this.hours + "</td>";
    html += "<td><a rel='nofollow' data-method='delete' href='/entries/' " + this.id + "'>DELETE</a></td>";
    html += "</tr>";
    return html;
  }
}

var bindForm = function() {
  $('form').submit(function(event) {
    event.preventDefault();

    var values = $(this).serialize();

    var posting = $.post('/entries', values);

    posting.done(function(data) {
      var entry = new Entry(data);
      $('.entries').append(entry.makeHTML());
    });

  }); 
}

 