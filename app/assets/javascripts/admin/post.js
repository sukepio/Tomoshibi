//イメージの切り替え
$(function(){   
  const images = document.querySelectorAll('.thumb');
  images.forEach(function(image, index){
    image.onclick = function(){
      document.getElementById('bigimg').src = this.src;
    }
  });
});