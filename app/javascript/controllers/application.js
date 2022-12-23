import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

let images
let mainImage

document.addEventListener("turbo:load", function() {
    
    images = document.getElementsByClassName("changeimage")
    mainImage = document.getElementById("mainimage")

    Array.from(images).forEach(function(image) {
    image.addEventListener('click', swapImages) 
    
    })
});

let swapImages = function() {
    mainImage.src = this.src
    mainImage.scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
};


