// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.countdown
//= require bootstrap-sprockets
//= require countdown
//= require prism

$(document).on("ready", function() {
  setTimeout(function() {
    $(".hide-flash").fadeOut("normal");
  }, 5000);

  check_question_type();
  check_box_state();
  check_box_state_edit();

  $("#question_question_type").on("change",function() {
    if (this.value === "text"){
      $(".remove-button").trigger("click");
      $(".add-button").trigger("click");
      $(".add-button").hide();
      $(".check-box-remove").hide();
      $(".answer-title").html("Answer");
    }else{
      $(".check-box").prop("checked", false);
      $(".add-button").show();
      $(".check-box-remove").show();
      $(".answer-title").html("Option");
      if (this.value === "single_choice") {
        $(".check-box:first").prop("checked", true);
      }
    }
  });

  if ($("#question_question_type").val() == "text") {
    $(".remove-button").trigger("click");
    $(".add-button").trigger("click");
    $(".add-button").hide();
    $(".check-box-remove").hide();
    $(".answer-title").html("Answer");
  }
});

$(document).on("page:load page:update", check_box_state);
$(document).on("page:load page:update", check_box_state_edit);

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".form-group").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
  answer_title();
}

function check_question_type() {
  if ($("span.question_type_text").text() === "Text"){
    $(".add-button").hide();
    $(".check-box-remove").hide();
    $(".answer-title").html("Answer");
  }else{
    $(".add-button").show();
    $(".check-box-remove").show();
    $(".answer-title").html("Option");
  }
}

function answer_title() {
  if ($("#question_question_type").val() === "text"){
    $(".answer-title").html("Answer");
  }else{
    $(".answer-title").html("Option");
  }
}

function check_box_state() {
  $(".check-box").on("change",function(){
    if ($("#question_question_type").val() === "single_choice"){
      $(".check-box").not(this).prop("checked", false);
    }
  });
}

function check_box_state_edit() {
  $(".check-box").on("change",function(){
    if ($("span.question_type_text").text() === "Single_choice"){
      $(".check-box").not(this).prop("checked", false);
    }
  });
}
