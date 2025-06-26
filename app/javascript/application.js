// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails" 
import "controllers"

function createBubble() {
  const bubble = document.createElement('div');
  bubble.className = 'bubble';
  
  const randomX = Math.random() * 100;
  const randomDelay = Math.random() * 6;
  const randomSize = Math.random() * 3 + 2;
  
  bubble.style.left = randomX + '%';
  bubble.style.animationDelay = randomDelay + 's';
  bubble.style.width = randomSize + 'px';
  bubble.style.height = randomSize + 'px';
  
  const waveContainer = document.querySelector('.wave-container');
  if (waveContainer) {
    waveContainer.appendChild(bubble);
    
    setTimeout(() => {
      if (bubble.parentNode) {
        bubble.parentNode.removeChild(bubble);
      }
    }, 6000 + randomDelay * 1000);
  }
}

// 定期的に泡を生成
document.addEventListener('DOMContentLoaded', function() {
  setInterval(createBubble, 800);
  
  // 初期の泡を生成
  for (let i = 0; i < 5; i++) {
    setTimeout(createBubble, i * 200);
  }
});