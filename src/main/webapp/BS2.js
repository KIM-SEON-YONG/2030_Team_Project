// 슬라이드 변수
const sliderWrapper = document.querySelector('.slider-wrapper');
const slides = document.querySelectorAll('.slide');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');

let currentIndex = 0;
const slideWidth = slides[0].clientWidth + 20; // 슬라이드 너비 + 여백
const totalSlides = slides.length;

// 슬라이드 이동 함수
function moveSlide(index) {
    if (index < 0) {
        currentIndex = totalSlides - 1;
    } else if (index >= totalSlides) {
        currentIndex = 0;
    } else {
        currentIndex = index;
    }
    sliderWrapper.style.transform = `translateX(${-currentIndex * slideWidth}px)`;
}

// 이전 버튼 클릭 이벤트
prevBtn.addEventListener('click', () => {
    moveSlide(currentIndex - 1);
});

// 다음 버튼 클릭 이벤트
nextBtn.addEventListener('click', () => {
    moveSlide(currentIndex + 1);
});

// 자동 슬라이드 기능 (3초마다 변경)
setInterval(() => {
    moveSlide(currentIndex + 1);
}, 3000);
