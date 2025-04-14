document.addEventListener("turbo:load", () => {
  if (typeof google === "undefined") return;

  const mapElement = document.getElementById("map");
  if (!mapElement || typeof fishingSpots === "undefined") return;

  const map = new google.maps.Map(mapElement, {
    center: { lat: 34.6937, lng: 135.5023 }, // 初期表示：大阪
    zoom: 10,
  });

  // 🎣 釣り場のピン
  fishingSpots.forEach(spot => {
    const marker = new google.maps.Marker({
      position: { lat: spot.latitude, lng: spot.longitude },
      map: map,
      title: spot.name,
    });

    marker.addListener("click", () => {
      window.location.href = `/fishing_spots/${spot.id}/posts`;
    });
  });

  // 📍 現在地マーカー表示用関数
  const showCurrentLocation = (lat, lng) => {
    const currentPos = { lat, lng };

    // 中心を現在地に移動
    map.setCenter(currentPos);

    // 🔵 現在地マーカー（青丸）
    new google.maps.Marker({
      position: currentPos,
      map: map,
      title: "現在地",
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        scale: 8,
        fillColor: '#4285F4',
        fillOpacity: 1,
        strokeWeight: 2,
        strokeColor: 'white',
      },
    });

    // 🌊 波紋エフェクト
    new google.maps.Circle({
      strokeColor: '#4285F4',
      strokeOpacity: 0.4,
      strokeWeight: 1,
      fillColor: '#4285F4',
      fillOpacity: 0.2,
      map: map,
      center: currentPos,
      radius: 100,
    });
  };

  // 🌐 現在地取得（失敗しても仮の座標を使う）
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        console.log("✅ 現在地取得成功", position); // ← ここ追加！
        showCurrentLocation(
          position.coords.latitude,
          position.coords.longitude
        );
      },
      (error) => {
        console.warn("⚠️ 現在地の取得に失敗しました:", error.message);
        showCurrentLocation(34.6937, 135.5023); // fallback: 大阪
      }
    );
  } else {
    console.warn("⚠️ このブラウザでは現在地取得がサポートされていません");
    showCurrentLocation(34.6937, 135.5023); // fallback
  }
});
