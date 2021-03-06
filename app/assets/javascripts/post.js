$(function() {
  $(document).on('turbolinks:load', function () {
   function readURL(input) {
     if (input.files && input.files[0]) {
       var reader = new FileReader();
       reader.onload = function (e) {
         $('#image_prev').attr('src', e.target.result);
       }
       reader.readAsDataURL(input.files[0]);
     }
   }
   $("#post_image").change(function(){
   readURL(this);
   });
  });
});

//イメージの切り替え
$(function(){   
  const images = document.querySelectorAll('.thumb');
  images.forEach(function(image, index){
    image.onclick = function(){
      document.getElementById('bigimg').src = this.src;
    }
  });
});