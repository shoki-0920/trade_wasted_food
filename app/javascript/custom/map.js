document.addEventListener("turbo:load", () => {
    if (typeof google === "undefined") return;
  
    const mapElement = document.getElementById("map");
    if (!mapElement || typeof fishingSpots === "undefined") return;
  
    const map = new google.maps.Map(mapElement, {
      center: { lat: 34.6937, lng: 135.5023 }, // 初期表示（例：大阪）
      zoom: 10,
    });
  
    fishingSpots.forEach(spot => {
      const marker = new google.maps.Marker({
        position: { lat: spot.latitude, lng: spot.longitude },
        map: map,
        title: spot.name,
      });
  
      marker.addListener("click", () => {
        // 釣り場に紐づく投稿一覧ページへ遷移（ルーティングが /fishing_spots/:id/posts の場合）
        window.location.href = `/fishing_spots/${spot.id}/posts`;
      });
    });
  });
  