import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

let images
let mainImage
// let dates = {
//     currentMonth: {
//         name: "December",
//         dayCount: 31,
//         firstDayInMonth: 4,
//         allowedDates: [],
//     },
//     nextMonth: {
//         name: "January",
//         dayCount: 31,
//         firstDayInMonth: 7,
//         allowedDates: [],
//     },
// }

document.addEventListener("turbo:load", function() {
    
    images = document.getElementsByClassName("changeimage")
    mainImage = document.getElementById("mainimage")

    Array.from(images).forEach(function(image) {
    image.addEventListener('click', swapImages) 
    })
    let calendarElement = document.getElementById("calendar")
    if (calendarElement) {
        console.log(JSON.parse(calendarElement.getAttribute('data')))
        let calendarData = JSON.parse(calendarElement.getAttribute('data'))
        generateCalendar(calendarData,calendarElement)
    }
});

let swapImages = function() {
    mainImage.src = this.src
    mainImage.scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
};




function generateCalendar(calendarData,calendar_element) {
    
    generateCalendarMonth(calendarData.currentMonth,calendar_element)
    generateCalendarMonth(calendarData.nextMonth,calendar_element)
}

function generateCalendarMonth(monthData,calendarElement) {
    let monthDaysElement = document.createElement('ul')
    monthDaysElement.innerHTML += `<div class="month">${monthData.name}</div>`
    let weekDaysElements = `<ul class="weekdays"><li>Mo</li><li>Tu</li><li>We</li><li>Th</li><li>Fr</li><li>Sa</li><li>Su</li></ul>`
    monthDaysElement.innerHTML += weekDaysElements
    let dateField = document.getElementById("datefield")
    monthDaysElement.classList.add("days")
    monthDaysElement.innerHTML += `${'<li></li>'.repeat(monthData.firstDayInMonth-1)}`
    for (let i = 1; i <= monthData.dayCount;i++) {
        let dateElement = document.createElement('li')
        let spanElement = document.createElement('span')
        spanElement.innerHTML = i
        if (monthData.allowedDates.includes(getDate(monthData,i))) {
            spanElement.classList.add('active')
            spanElement.addEventListener("click", function(){ 
                dateField.value = getDate(monthData,i)
            }); 
        }

        dateElement.append(spanElement)
        monthDaysElement.append(dateElement)
    }
    monthDaysElement.classList.add("col-6")
    calendarElement.append(monthDaysElement)
} 

function getDate(monthData,date) {
    return monthData.allowedDates[0].slice(0, 8)+String(date).padStart(2, '0')
}





