var buffercheck;
var videobuffer;
var video = document.getElementById('background-video');
var refreshcount = 0;

// Video and Audio

$(document).ready(function(){
	
	mute();

	video.play();

	$('.mute').click(function(e){
		switchAudio();
		return false;
	});

});

function switchAudio() {
	//if video is muted, unmute and show audio on button and vice versa
	if(video.muted) {
		unMute();
	}
	else {
		mute();
	}
}

function unMute(){
	ga('send', 'Audio', 'Unmute');
	video.muted = false;
	$('.mute').text('Mute');	
}

function mute(){
	ga('send', 'Audio', 'Mute');
	video.muted = true;
	$('.mute').text('Play Sound');	
}


// Show / Hide Login / Signup Forms

$('.signup-button').click(function(e){
    e.preventDefault();
    var $showform = $('.signup-form');
    var $hideform = $('.login-form');
           
    $showform.toggle(0);
    $hideform.toggle(0);

    if($showform.is(':visible')) 
    {
      $(this).text("Log In")
    }
    else 
    {
      $(this).text("Sign Up")
    } 
  }); 