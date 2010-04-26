$(document).ready(function(){
  $("ul.star-ratingActive li.oneStar").hover(function(){
    $(this).parent().removeClass("ratedTwoStars").removeClass("ratedThreeStars").removeClass("ratedFourStars").removeClass("ratedFiveStars").addClass("ratedOneStar");
  });
  $("ul.star-ratingActive li.twoStars").hover(function(){
    $(this).parent().removeClass("ratedOneStar").removeClass("ratedThreeStars").removeClass("ratedFourStars").removeClass("ratedFiveStars").addClass("ratedTwoStars");
  });
  $("ul.star-ratingActive li.threeStars").hover(function(){
    $(this).parent().removeClass("ratedOneStar").removeClass("ratedTwoStars").removeClass("ratedFourStars").removeClass("ratedFiveStars").addClass("ratedThreeStars");
  });
  $("ul.star-ratingActive li.fourStars").hover(function(){
    $(this).parent().removeClass("ratedOneStar").removeClass("ratedTwoStars").removeClass("ratedThreeStars").removeClass("ratedFiveStars").addClass("ratedFourStars");
  });
  $("ul.star-ratingActive li.fiveStars").hover(function(){
    $(this).parent().removeClass("ratedOneStar").removeClass("ratedTwoStars").removeClass("ratedThreeStars").removeClass("ratedFourStars").addClass("ratedFiveStars");
  });
  $("ul.star-ratingActive").hover(function(){
  }, function(){
    $(this).removeClass("ratedOneStar").removeClass("ratedTwoStars").removeClass("ratedThreeStars").removeClass("ratedFourStars").removeClass("ratedFiveStars");
  });
  
  $("div#favoriteData_dropdown").hide();
  
  $("div#favoriteData a.buttonLink").toggle(
    function(){
       $(this).addClass("active");
       $("div#favoriteData_dropdown").slideDown("slow");
    },
    function(){
         $(this).removeClass("active");
         $("div#favoriteData_dropdown").slideUp("slow");
      } 
  );
  
  $("#released").datepicker({ changeYear: true, changeMonth: true });
  $("#period_start").datepicker({ changeYear: true, changeMonth: true });
  $("#period_end").datepicker({ changeYear: true, changeMonth: true });
  
  $("li#moveBtn a.buttonLink").toggle(
    function(){
       $(this).addClass("active");
       $("div#favoriteData_dropdown").slideDown("slow");
    },
    function(){
         $(this).removeClass("active");
         $("div#favoriteData_dropdown").slideUp("slow");
      } 
  );
  
  $("ul#additionalFields_details").hide();
  
  $("div#additionalFields h3 a").toggle(
    function(){
       $("ul#additionalFields_details").slideDown("slow");
    },
    function(){
         $("ul#additionalFields_details").slideUp("slow");
      } 
  
  );
  
  $("form.generateAPI").hide();
  
  $("div#additionalKeys a.addLink").toggle(
    function(){
       $("form.generateAPI").slideDown("slow");
    },
    function(){
         $("form.generateAPI").slideUp("slow");
      } 
  
  );
  
  $("div#addTag").hide();
  
  $("a#addTagLink").toggle(
    function(){
       $("div#addTag").slideDown("slow");
    },
    function(){
         $("div#addTag").slideUp("slow");
      } 
  );
  
  $("div#addFolder").hide();
  
  $("a#addFolderLink").toggle(
    function(){
       $("div#addFolder").slideDown("slow");
    },
    function(){
         $("div#addFolder").slideUp("slow");
      } 
  );
  
  $("ul.tabs").tabs("div.tab_panes > div.tab_pane", {
    current: 'active'
  });
  
});
