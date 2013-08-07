var buffercheck;
var videobuffer;
var video = document.getElementById('background-video');
var refreshcount = 0;


$(document).ready(function(){
	
	mute();

	video.play();

	$('.mute').click(function(e){
		switchAudio();
		return false;
	});

});

function switchAudio() {
	//if video is muted, unmute and show audo on button and vice versa
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