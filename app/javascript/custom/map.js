document.addEventListener("turbo:load", () => {
  console.log("🚀 turbo:load イベント発火");
  if (typeof google === "undefined") {
    console.error("❌ google オブジェクトが存在しません");
    return;
  }
  
  const mapElement = document.getElementById("map");
  if (!mapElement) {
    console.error("❌ #map 要素が見つかりません");
    return;
  }
  if (typeof fishingSpots === "undefined") {
    console.error("❌ fishingSpots 変数が undefined です");
    return;
  }
  
  console.log("✅ Google Maps と fishingSpots の読み込み確認");
  
  const map = new google.maps.Map(mapElement, {
    center: { lat: 34.6937, lng: 135.5023 }, // 初期表示：大阪
    zoom: 10,
  });

  // 🎣 釣り場のピンを表示
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
    console.log("🖥️ 現在地を表示: ", currentPos);

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

  // 🌐 geolocation の利用チェック
  if ("geolocation" in navigator) {
    console.log("✅ navigator.geolocation が利用可能です");
    navigator.geolocation.getCurrentPosition(
      (position) => {
        console.log("✅ 現在地取得成功", position);
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
